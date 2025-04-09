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
  pas_alias_ip_range = {
    ip_cidr_range = "${var.alias_ip_inp}/32"
  }
  region             = join("-", slice(split("-", var.zone), 0, 2))
  subnetwork_project = var.subnetwork_project == "" ? var.project_id : var.subnetwork_project
}

resource "google_compute_address" "gcp_sap_nw_intip" {
  count        = var.target_size
  name         = var.instance_name
  address_type = "INTERNAL"
  subnetwork   = "projects/${local.subnetwork_project}/regions/${local.region}/subnetworks/${var.subnetwork}"
  region       = local.region
  project      = var.project_id
  purpose      = "GCE_ENDPOINT"
  address      = var.instance_ip


  lifecycle {
    create_before_destroy = true
  }
}

module "sap_nw_umig" {
  source               = "../../terraform-google-vm//modules/dr/umig-pas"
  project_id           = var.project_id
  subnetwork           = var.subnetwork
  subnetwork_project   = var.subnetwork_project
  source_image         = var.source_image_name
  source_image_project = var.source_image_project
  region               = local.region
  zone                 = var.zone
  hostname             = var.instance_name
  static_ips           = google_compute_address.gcp_sap_nw_intip.*.address
  machine_type         = var.instance_type
  auto_delete          = var.autodelete_disk
  disk_source          = google_compute_disk.gcp_sap_nw_boot_disk.id
  service_account = {
    email  = var.service_account_email
    scopes = ["cloud-platform"]
  }
  tags       = var.network_tags
  pd_kms_key = var.pd_kms_key
  labels     = var.labels
  metadata = {
    ssh-keys = "${var.gce_ssh_user}:${file("${var.gce_ssh_pub_key_file}")}"
  }
  num_instances         = var.target_size
  alias_ip_range        = var.alias_ip_inp != "" ? local.pas_alias_ip_range : var.alias_ip_range
  auto_append_hostname  = var.instance_name == ""
  create_instance_group = var.create_instance_group
  instance_group_name   = var.instance_group_name
  named_ports           = var.named_ports
}

resource "google_compute_disk" "gcp_sap_nw_boot_disk" {
  project  = var.project_id
  snapshot = var.instance_map[0].bdisk
  name     = var.instance_name
  type     = var.boot_disk_type
  zone     = var.zone
  size     = var.boot_disk_size


  # Add the disk_encryption_key block only if a pd_kms_key was provided
  dynamic "disk_encryption_key" {
    for_each = var.pd_kms_key != null ? [""] : []
    content {
      kms_key_self_link = var.pd_kms_key
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_disk" "gcp_sap_nw_usrsap" {
  count    = var.usrsap_disk_size > 0 ? var.target_size : 0
  project  = var.project_id
  snapshot = var.instance_map[count.index].addnldisk
  name     = "${var.instance_name}-${var.device_usrsap}"
  type     = var.usrsap_disk_type
  zone     = var.zone
  size     = var.usrsap_disk_size

  # Add the disk_encryption_key block only if a pd_kms_key was provided
  dynamic "disk_encryption_key" {
    for_each = var.pd_kms_key != null ? [""] : []
    content {
      kms_key_self_link = var.pd_kms_key
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_disk" "gcp_sap_nw_swap" {
  count   = var.swap_disk_size > 0 ? var.target_size : 0
  project = var.project_id
  name    = "${var.instance_name}-${var.device_swap}"
  type    = var.swap_disk_type
  zone    = var.zone
  size    = var.swap_disk_size

  # Add the disk_encryption_key block only if a pd_kms_key was provided
  dynamic "disk_encryption_key" {
    for_each = var.pd_kms_key != null ? [""] : []
    content {
      kms_key_self_link = var.pd_kms_key
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}


resource "google_compute_attached_disk" "gcp_sap_nw_attached_usrsap" {
  count       = var.usrsap_disk_size > 0 ? var.target_size : 0
  disk        = google_compute_disk.gcp_sap_nw_usrsap.*.self_link[count.index]
  instance    = split("/", module.sap_nw_umig.instances_self_links[count.index])[10]
  device_name = "${split("/", module.sap_nw_umig.instances_self_links[count.index])[10]}-${var.device_usrsap}"
  project     = var.project_id
  zone        = var.zone

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_attached_disk" "gcp_sap_nw_attached_swap" {
  count       = var.swap_disk_size > 0 ? var.target_size : 0
  disk        = google_compute_disk.gcp_sap_nw_swap.*.self_link[count.index]
  instance    = split("/", module.sap_nw_umig.instances_self_links[count.index])[10]
  device_name = "${split("/", module.sap_nw_umig.instances_self_links[count.index])[10]}-${var.device_swap}"
  project     = var.project_id
  zone        = var.zone

  lifecycle {
    create_before_destroy = true
  }
}