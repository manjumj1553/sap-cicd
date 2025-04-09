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

locals {
  aas_alias_ip_range_a = [
    for alias_ip_a in var.alias_ip_inp_a : {
      ip_cidr_range = "${alias_ip_a}/32"
    }
  ]
  aas_alias_ip_range_b = [
    for alias_ip_b in var.alias_ip_inp_b : {
      ip_cidr_range = "${alias_ip_b}/32"
    }
  ]
}

module "instance_template" {
  source         = "../terraform-google-vm//modules/instance_template"
  name_prefix    = var.prefix
  machine_type   = var.instance_type
  project_id     = var.project_id
  region         = var.region
  alias_ip_range = var.alias_ip_range
  metadata = {
    ssh-keys = "${var.ssh_user}:${file("${var.public_key_path}")}"
  }

  service_account = {
    email  = var.service_account_email
    scopes = ["cloud-platform"]
  }

  subnetwork         = var.subnetwork
  subnetwork_project = var.subnetwork_project
  tags               = var.network_tags

  source_image         = var.source_image_name
  source_image_project = var.source_image_project

  disk_size_gb = var.boot_disk_size
  disk_type    = var.boot_disk_type
  auto_delete  = var.autodelete_disk
  labels       = var.labels
  pd_kms_key   = var.pd_kms_key
}

resource "google_compute_address" "internal_ip_a" {
  count        = var.target_size_a
  name         = var.instance_name_a[count.index]
  address_type = "INTERNAL"
  subnetwork   = "projects/${var.subnetwork_project}/regions/${var.region}/subnetworks/${var.subnetwork}"
  region       = var.region
  project      = var.project_id
  purpose      = "GCE_ENDPOINT"
  address      = var.instance_ip_a[count.index]

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_address" "internal_ip_b" {
  count        = var.target_size_b
  name         = var.instance_name_b[count.index]
  address_type = "INTERNAL"
  subnetwork   = "projects/${var.subnetwork_project}/regions/${var.region}/subnetworks/${var.subnetwork}"
  region       = var.region
  project      = var.project_id
  purpose      = "GCE_ENDPOINT"
  address      = var.instance_ip_b[count.index]

  lifecycle {
    create_before_destroy = true
  }
}

module "umig_a" {
  source                = "../terraform-google-vm//modules/umig_aas"
  project_id            = var.project_id
  region                = var.region
  zone                  = var.zone_a
  subnetwork            = var.subnetwork
  subnetwork_project    = var.subnetwork_project
  static_ips            = google_compute_address.internal_ip_a.*.address
  hostname              = var.instance_name_a
  num_instances         = 2
  instance_template     = module.instance_template.self_link
  alias_ip_range        = local.aas_alias_ip_range_a
  create_instance_group = var.create_instance_group
  instance_group_name   = var.instance_group_name
}

module "umig_b" {
  source                = "../terraform-google-vm//modules/umig_aas"
  project_id            = var.project_id
  region                = var.region
  zone                  = var.zone_b
  subnetwork            = var.subnetwork
  subnetwork_project    = var.subnetwork_project
  static_ips            = google_compute_address.internal_ip_b.*.address
  hostname              = var.instance_name_b
  num_instances         = 2
  instance_template     = module.instance_template.self_link
  alias_ip_range        = local.aas_alias_ip_range_b
  create_instance_group = var.create_instance_group
  instance_group_name   = var.instance_group_name
}

resource "google_compute_disk" "gcp_nw_pd_0_a" {
  count   = var.target_size_a
  project = var.project_id
  name    = "${var.instance_name_a[count.index]}-usrsap"
  type    = var.usrsap_disk_type
  zone    = var.zone_a
  size    = var.usr_sap_size

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

resource "google_compute_disk" "gcp_nw_pd_0_b" {
  count   = var.target_size_b
  project = var.project_id
  name    = "${var.instance_name_b[count.index]}-usrsap"
  type    = var.usrsap_disk_type
  zone    = var.zone_b
  size    = var.usr_sap_size

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

resource "google_compute_disk" "gcp_nw_pd_1_a" {
  count   = var.target_size_a
  project = var.project_id
  name    = "${var.instance_name_a[count.index]}-swap"
  type    = var.swap_disk_type
  zone    = var.zone_a
  size    = var.swap_size

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

resource "google_compute_disk" "gcp_nw_pd_1_b" {
  count   = var.target_size_b
  project = var.project_id
  name    = "${var.instance_name_b[count.index]}-swap"
  type    = var.swap_disk_type
  zone    = var.zone_b
  size    = var.swap_size

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

resource "google_compute_attached_disk" "gcp_nw_attached_pd_0_a" {
  count       = var.target_size_a
  disk        = google_compute_disk.gcp_nw_pd_0_a.*.self_link[count.index]
  instance    = split("/", module.umig_a.instances_self_links[count.index])[10]
  device_name = "${split("/", module.umig_a.instances_self_links[count.index])[10]}-usrsap"
  project     = var.project_id
  zone        = var.zone_a

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_attached_disk" "gcp_nw_attached_pd_0_b" {
  count       = var.target_size_b
  disk        = google_compute_disk.gcp_nw_pd_0_b.*.self_link[count.index]
  instance    = split("/", module.umig_b.instances_self_links[count.index])[10]
  device_name = "${split("/", module.umig_b.instances_self_links[count.index])[10]}-usrsap"
  project     = var.project_id
  zone        = var.zone_b

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_attached_disk" "gcp_nw_attached_pd_1_a" {
  count       = var.target_size_a
  disk        = google_compute_disk.gcp_nw_pd_1_a.*.self_link[count.index]
  instance    = split("/", module.umig_a.instances_self_links[count.index])[10]
  device_name = "${split("/", module.umig_a.instances_self_links[count.index])[10]}-swap"
  project     = var.project_id
  zone        = var.zone_a

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_attached_disk" "gcp_nw_attached_pd_1_b" {
  count       = var.target_size_b
  disk        = google_compute_disk.gcp_nw_pd_1_b.*.self_link[count.index]
  instance    = split("/", module.umig_b.instances_self_links[count.index])[10]
  device_name = "${split("/", module.umig_b.instances_self_links[count.index])[10]}-swap"
  project     = var.project_id
  zone        = var.zone_b

  lifecycle {
    create_before_destroy = true
  }
}