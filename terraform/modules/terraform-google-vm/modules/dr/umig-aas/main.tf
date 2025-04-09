/**
 * Copyright 2019 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

locals {
  num_instances        = length(var.static_ips) == 0 ? var.num_instances : length(var.static_ips)
  auto_append_hostname = var.auto_append_hostname || local.num_instances > 1

  # local.static_ips is the same as var.static_ips with a dummy element appended
  # at the end of the list to work around "list does not have any elements so cannot
  # determine type" error when var.static_ips is empty
  static_ips = concat(var.static_ips, ["NOT_AN_IP"])

  instance_group_count = min(
    local.num_instances,
    length(data.google_compute_zones.available.names),
  )
}


###############
# Data Sources
###############

data "google_compute_zones" "available" {
  project = var.project_id
  region  = var.region
  status  = "UP"
}

data "google_compute_image" "image" {
  project = var.source_image_project
  name    = var.source_image
}

#############
# Instances
#############
resource "google_compute_instance" "compute_instance" {
  provider                  = google
  count                     = local.num_instances
  project                   = var.project_id
  name                      = var.hostname[count.index]
  machine_type              = var.machine_type
  labels                    = var.labels
  metadata                  = var.metadata
  zone                      = var.zone != "" ? var.zone : data.google_compute_zones.available.names[count.index % length(data.google_compute_zones.available.names)]
  can_ip_forward            = var.can_ip_forward
  tags                      = var.tags
  allow_stopping_for_update = true
  deletion_protection       = true

  boot_disk {
    auto_delete = var.auto_delete
    device_name = "${var.hostname[count.index]}-${var.device_boot}"
    source      = var.disk_source[count.index]
  }

  network_interface {
    network            = var.network
    subnetwork         = var.subnetwork
    subnetwork_project = var.subnetwork_project
    network_ip         = length(var.static_ips) == 0 ? "" : element(local.static_ips, count.index)

    dynamic "access_config" {
      for_each = var.access_config
      content {
        nat_ip       = access_config.value.nat_ip
        network_tier = access_config.value.network_tier
      }
    }

    dynamic "alias_ip_range" {
      for_each = var.alias_ip_range == null ? [] : [var.alias_ip_range]
      content {
        ip_cidr_range         = lookup(element(alias_ip_range.value, 0), "ip_cidr_range", null)
        subnetwork_range_name = lookup(element(alias_ip_range.value, 0), "subnetwork_range_name", null)
      }
    }
  }

  dynamic "service_account" {
    for_each = [var.service_account]
    content {
      email  = lookup(service_account.value, "email", null)
      scopes = lookup(service_account.value, "scopes", null)
    }
  }

  # scheduling must have automatic_restart be false when preemptible is true.
  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }

  lifecycle {
    ignore_changes        = [metadata, attached_disk]
    create_before_destroy = true
  }
}

resource "google_compute_instance_group" "instance_group" {
  provider = google
  count    = var.create_instance_group ? local.instance_group_count : 0
  name     = var.instance_group_name
  project  = var.project_id
  zone     = var.zone != "" ? var.zone : element(data.google_compute_zones.available.names, count.index)
  instances = matchkeys(
    google_compute_instance.compute_instance.*.self_link,
    google_compute_instance.compute_instance.*.zone,
    [var.zone],
  )

  dynamic "named_port" {
    for_each = var.named_ports
    content {
      name = named_port.value.name
      port = named_port.value.port
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}