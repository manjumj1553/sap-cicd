/**
 * Copyright 2021 Google LLC
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
  subnetwork_project = var.subnetwork_project == "" ? var.project_id : var.subnetwork_project
  alias_ip_range = var.alias_ip_inp == null ? [] : [
    for alias_ip in var.alias_ip_inp : {
      ip_cidr_range = "${alias_ip}/32"
    }
  ]
}

resource "google_compute_address" "gcp_sap_nw_intip" {
  count        = var.target_size
  name         = var.instance_name[count.index]
  address_type = "INTERNAL"
  subnetwork   = "projects/${local.subnetwork_project}/regions/${var.region}/subnetworks/${var.subnetwork}"
  region       = var.region
  project      = var.project_id
  purpose      = "GCE_ENDPOINT"
  address      = var.instance_ip[count.index]

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_disk" "gcp_sap_nw_usrsap" {
  count   = var.target_size
  project = var.project_id
  name    = "${var.instance_name[count.index]}-${var.device_usrsap}"
  type    = var.usrsap_disk_type
  zone    = var.zone
  size    = var.usrsap_disk_size

  # Add the disk_encryption_key block only if a pd_kms_key was provided
  dynamic "disk_encryption_key" {
    for_each = var.pd_kms_key != "" ? [""] : []
    content {
      kms_key_self_link = var.pd_kms_key
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_disk" "gcp_sap_nw_swap" {
  count   = var.target_size
  project = var.project_id
  name    = "${var.instance_name[count.index]}-${var.device_swap}"
  type    = var.swap_disk_type
  zone    = var.zone
  size    = var.swap_disk_size

  # Add the disk_encryption_key block only if a pd_kms_key was provided
  dynamic "disk_encryption_key" {
    for_each = var.pd_kms_key != "" ? [""] : []
    content {
      kms_key_self_link = var.pd_kms_key
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_attached_disk" "gcp_sap_nw_attached_usrsap" {
  count   = var.target_size
  project = var.project_id
  zone    = var.zone
  # count       = var.usrsap_disk_size > 0 ? 1 : 0
  device_name = "${var.instance_name[count.index]}-${var.device_usrsap}"
  disk        = element(google_compute_disk.gcp_sap_nw_usrsap.*.self_link, count.index)
  instance    = google_compute_instance.gcp_nw.*.self_link[count.index]

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_attached_disk" "gcp_sap_nw_attached_swap" {
  count   = var.target_size
  project = var.project_id
  zone    = var.zone
  # count       = var.swap_disk_size > 0 ? 1 : 0
  device_name = "${var.instance_name[count.index]}-${var.device_swap}"
  disk        = element(google_compute_disk.gcp_sap_nw_swap.*.self_link, count.index)
  instance    = google_compute_instance.gcp_nw.*.self_link[count.index]

  lifecycle {
    create_before_destroy = true
  }
}

data "google_compute_image" "image" {
  project = var.source_image_project
  name    = var.source_image_name
}

resource "google_compute_instance" "gcp_nw" {
  count                     = var.target_size
  project                   = var.project_id
  name                      = var.instance_name[count.index]
  machine_type              = var.instance_type
  zone                      = var.zone
  tags                      = var.network_tags
  allow_stopping_for_update = true
  can_ip_forward            = true
  deletion_protection       = true

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }

  boot_disk {
    auto_delete       = var.autodelete_disk
    device_name       = "${var.instance_name[count.index]}-${var.device_boot}"
    kms_key_self_link = var.pd_kms_key

    initialize_params {
      image = data.google_compute_image.image.self_link
      size  = var.boot_disk_size
      type  = var.boot_disk_type
    }
  }

  network_interface {
    subnetwork         = var.subnetwork
    subnetwork_project = local.subnetwork_project
    network_ip         = var.instance_ip[count.index]
    dynamic "access_config" {
      for_each = [for i in [""] : i if var.use_public_ip]
      content {}
    }

    dynamic "alias_ip_range" {
      for_each = local.alias_ip_range
      content {
        ip_cidr_range = alias_ip_range.value.ip_cidr_range
      }
    }
  }

  metadata = {
    ssh-keys = "${var.gce_ssh_user}:${file("${var.gce_ssh_pub_key_file}")}"
  }

  lifecycle {
    # Ignore changes in the instance metadata, since it is modified by the SAP startup script.
    # https://github.com/terraform-providers/terraform-provider-google/issues/2098
    ignore_changes        = [metadata, attached_disk]
    create_before_destroy = true
  }

  service_account {
    email  = var.service_account_email
    scopes = ["cloud-platform"]
  }

  labels = var.labels
}

data "google_compute_instance" "sap_instance" {
  count   = length(var.instance_name)
  name    = google_compute_instance.gcp_nw[count.index].name
  project = var.project_id
  zone    = var.zone
}