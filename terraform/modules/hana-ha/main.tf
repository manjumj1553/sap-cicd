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

provider "google" {}

data "google_compute_subnetwork" "subnetwork" {
  name    = var.subnetwork
  region  = local.region
  project = local.subnetwork_project
}

module "sap_hana_template" {
  source       = "../terraform-google-vm//modules/instance_template"
  name_prefix  = var.instance_name
  machine_type = var.instance_type
  project_id   = var.project_id
  region       = local.region

  metadata = {
    ssh-keys = "${var.gce_ssh_user}:${file("${var.gce_ssh_pub_key_file}")}"
  }

  service_account = {
    email  = var.service_account_email
    scopes = ["cloud-platform"]
  }

  subnetwork           = var.subnetwork
  subnetwork_project   = local.subnetwork_project
  tags                 = var.network_tags
  can_ip_forward       = true
  source_image         = var.source_image_name
  source_image_project = var.source_image_project
  disk_size_gb         = var.boot_disk_size
  disk_type            = var.boot_disk_type
  auto_delete          = var.autodelete_disk
  labels               = var.labels
  pd_kms_key           = var.pd_kms_key
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
  source               = "../terraform-google-vm//modules/umig"
  project_id           = var.project_id
  region               = local.region
  zone                 = var.zone
  subnetwork           = var.subnetwork
  subnetwork_project   = var.subnetwork_project
  static_ips           = [google_compute_address.gcp_sap_hana_intip.address]
  hostname             = var.instance_name
  auto_append_hostname = var.instance_name == ""
  num_instances        = var.target_size
  instance_template    = module.sap_hana_template.self_link
  instance_group_name  = var.instance_group_name
}

resource "google_compute_disk" "gcp_sap_hana_data" {
  project = var.project_id
  name    = "${var.instance_name}-data"
  type    = "pd-balanced"
  zone    = var.zone
  size    = var.hana_data_size

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
  name    = "${var.instance_name}-log"
  type    = var.hana_log_disk_type
  zone    = var.zone
  size    = var.hana_log_size

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
  name    = "${var.instance_name}-shared"
  type    = var.hana_shared_disk_type
  zone    = var.zone
  size    = var.hana_shared_size

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
  name    = "${var.instance_name}-usrsap"
  type    = var.hana_usr_disk_type
  zone    = var.zone
  size    = var.hana_usr_size

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
  name    = "${var.instance_name}-swap"
  type    = var.hana_swap_disk_type
  zone    = var.zone
  size    = var.hana_swap_size

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

resource "google_compute_disk" "gcp_sap_addon_disks" {
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

resource "google_compute_attached_disk" "data" {
  disk        = google_compute_disk.gcp_sap_hana_data.id
  instance    = element(split("/", element(tolist(module.sap_hana_umig.instances_self_links), 0)), 10)
  device_name = "${element(split("/", element(tolist(module.sap_hana_umig.instances_self_links), 0)), 10)}-data"
  project     = var.project_id
  zone        = var.zone

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_attached_disk" "log" {
  disk        = google_compute_disk.gcp_sap_hana_log.id
  instance    = element(split("/", element(tolist(module.sap_hana_umig.instances_self_links), 0)), 10)
  device_name = "${element(split("/", element(tolist(module.sap_hana_umig.instances_self_links), 0)), 10)}-log"
  project     = var.project_id
  zone        = var.zone

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_attached_disk" "shared" {
  disk        = google_compute_disk.gcp_sap_hana_shared.id
  instance    = element(split("/", element(tolist(module.sap_hana_umig.instances_self_links), 0)), 10)
  device_name = "${element(split("/", element(tolist(module.sap_hana_umig.instances_self_links), 0)), 10)}-shared"
  project     = var.project_id
  zone        = var.zone

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_attached_disk" "usrsap" {
  disk        = google_compute_disk.gcp_sap_hana_usrsap.id
  instance    = element(split("/", element(tolist(module.sap_hana_umig.instances_self_links), 0)), 10)
  device_name = "${element(split("/", element(tolist(module.sap_hana_umig.instances_self_links), 0)), 10)}-usrsap"
  project     = var.project_id
  zone        = var.zone

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_attached_disk" "swap" {
  disk        = google_compute_disk.gcp_sap_hana_swap.id
  instance    = element(split("/", element(tolist(module.sap_hana_umig.instances_self_links), 0)), 10)
  device_name = "${element(split("/", element(tolist(module.sap_hana_umig.instances_self_links), 0)), 10)}-swap"
  project     = var.project_id
  zone        = var.zone

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_attached_disk" "addon_disks" {
  count       = length(var.hana_addon_disks.name)
  disk        = google_compute_disk.gcp_sap_addon_disks[count.index].id
  instance    = element(split("/", element(tolist(module.sap_hana_umig.instances_self_links), 0)), 10)
  device_name = "${element(split("/", element(tolist(module.sap_hana_umig.instances_self_links), 0)), 10)}-${var.hana_addon_disks.name[count.index]}"
  project     = var.project_id
  zone        = var.zone

  lifecycle {
    create_before_destroy = true
  }
}