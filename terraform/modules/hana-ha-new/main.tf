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
  region             = join("-", slice(split("-", var.zone), 0, 2))
  subnetwork_project = var.subnetwork_project == "" ? var.project_id : var.subnetwork_project
}

data "google_compute_subnetwork" "subnetwork" {
  name    = var.subnetwork
  region  = local.region
  project = local.subnetwork_project
}

resource "google_compute_address" "gcp_sap_hana_intip" {
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

module "sap_hana_umig" {
  source               = "../terraform-google-vm//modules/umig-new"
  project_id           = var.project_id
  subnetwork           = var.subnetwork
  subnetwork_project   = var.subnetwork_project
  source_image         = var.source_image_name
  source_image_project = var.source_image_project
  region               = local.region
  zone                 = var.zone
  hostname             = var.instance_name
  static_ips           = [google_compute_address.gcp_sap_hana_intip.address]
  machine_type         = var.instance_type
  disk_size            = var.boot_disk_size
  disk_type            = var.boot_disk_type
  auto_delete          = var.autodelete_disk
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
  num_instances        = var.target_size
  auto_append_hostname = var.instance_name == ""
  instance_group_name  = var.instance_group_name
  named_ports          = var.named_ports
}

resource "google_compute_disk" "gcp_sap_hana_data" {
  project = var.project_id
  name    = "${var.instance_name}-${var.device_data}"
  type    = var.data_disk_type
  zone    = var.zone
  size    = var.data_disk_size

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

resource "google_compute_disk" "gcp_sap_hana_log" {
  project = var.project_id
  name    = "${var.instance_name}-${var.device_log}"
  type    = var.log_disk_type
  zone    = var.zone
  size    = var.log_disk_size

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

resource "google_compute_disk" "gcp_sap_hana_shared" {
  project = var.project_id
  name    = "${var.instance_name}-${var.device_shared}"
  type    = var.shared_disk_type
  zone    = var.zone
  size    = var.shared_disk_size

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

resource "google_compute_disk" "gcp_sap_hana_usrsap" {
  project = var.project_id
  name    = "${var.instance_name}-${var.device_usrsap}"
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

resource "google_compute_disk" "gcp_sap_hana_swap" {
  project = var.project_id
  name    = "${var.instance_name}-${var.device_swap}"
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

resource "google_compute_disk" "gcp_sap_hana_addon_disks" {
  count   = length(var.hana_addon_disks.name)
  project = var.project_id
  name    = "${var.instance_name}-${var.hana_addon_disks.name[count.index]}"
  type    = var.hana_addon_disks.disk_type[count.index]
  zone    = var.zone
  size    = var.hana_addon_disks.disk_size_gb[count.index]

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

resource "google_compute_attached_disk" "gcp_sap_hana_attached_data" {
  disk        = google_compute_disk.gcp_sap_hana_data.id
  instance    = element(split("/", element(tolist(module.sap_hana_umig.instances_self_links), 0)), 10)
  device_name = "${element(split("/", element(tolist(module.sap_hana_umig.instances_self_links), 0)), 10)}-data"
  project     = var.project_id
  zone        = var.zone

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_attached_disk" "gcp_sap_hana_attached_log" {
  disk        = google_compute_disk.gcp_sap_hana_log.id
  instance    = element(split("/", element(tolist(module.sap_hana_umig.instances_self_links), 0)), 10)
  device_name = "${element(split("/", element(tolist(module.sap_hana_umig.instances_self_links), 0)), 10)}-log"
  project     = var.project_id
  zone        = var.zone

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_attached_disk" "gcp_sap_hana_attached_shared" {
  disk        = google_compute_disk.gcp_sap_hana_shared.id
  instance    = element(split("/", element(tolist(module.sap_hana_umig.instances_self_links), 0)), 10)
  device_name = "${element(split("/", element(tolist(module.sap_hana_umig.instances_self_links), 0)), 10)}-shared"
  project     = var.project_id
  zone        = var.zone

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_attached_disk" "gcp_sap_hana_attached_usrsap" {
  disk        = google_compute_disk.gcp_sap_hana_usrsap.id
  instance    = element(split("/", element(tolist(module.sap_hana_umig.instances_self_links), 0)), 10)
  device_name = "${element(split("/", element(tolist(module.sap_hana_umig.instances_self_links), 0)), 10)}-usrsap"
  project     = var.project_id
  zone        = var.zone

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_attached_disk" "gcp_sap_hana_attached_swap" {
  disk        = google_compute_disk.gcp_sap_hana_swap.id
  instance    = element(split("/", element(tolist(module.sap_hana_umig.instances_self_links), 0)), 10)
  device_name = "${element(split("/", element(tolist(module.sap_hana_umig.instances_self_links), 0)), 10)}-swap"
  project     = var.project_id
  zone        = var.zone

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_attached_disk" "gcp_sap_hana_attached_addon_disks" {
  count       = length(var.hana_addon_disks.name)
  disk        = google_compute_disk.gcp_sap_hana_addon_disks[count.index].id
  instance    = element(split("/", element(tolist(module.sap_hana_umig.instances_self_links), 0)), 10)
  device_name = "${element(split("/", element(tolist(module.sap_hana_umig.instances_self_links), 0)), 10)}-${var.hana_addon_disks.name[count.index]}"
  project     = var.project_id
  zone        = var.zone

  lifecycle {
    create_before_destroy = true
  }
}