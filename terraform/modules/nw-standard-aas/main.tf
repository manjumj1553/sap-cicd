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
}

resource "google_compute_disk" "gcp_nw_pd_0_a" {
  count   = length(var.instance_name_a)
  project = var.project_id
  name    = "${var.instance_name_a[count.index]}-nw-0"
  type    = var.usrsap_disk_type
  zone    = var.zone_a
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

resource "google_compute_disk" "gcp_nw_pd_0_b" {
  count   = length(var.instance_name_b)
  project = var.project_id
  name    = "${var.instance_name_b[count.index]}-nw-0"
  type    = var.usrsap_disk_type
  zone    = var.zone_b
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

resource "google_compute_disk" "gcp_nw_pd_1_a" {
  count   = length(var.instance_name_a)
  project = var.project_id
  name    = "${var.instance_name_a[count.index]}-nw-1"
  type    = var.swap_disk_type
  zone    = var.zone_a
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

resource "google_compute_disk" "gcp_nw_pd_1_b" {
  count   = length(var.instance_name_b)
  project = var.project_id
  name    = "${var.instance_name_b[count.index]}-nw-1"
  type    = var.swap_disk_type
  zone    = var.zone_b
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

resource "google_compute_attached_disk" "gcp_nw_attached_pd_0_a" {
  project     = var.project_id
  count       = length(var.instance_name_a)
  device_name = "${var.instance_name_a[count.index]}-${var.device_1}"
  disk        = element(google_compute_disk.gcp_nw_pd_0_a[count.index].*.self_link, count.index)
  instance    = google_compute_instance.gcp_nw_a[count.index].self_link

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_attached_disk" "gcp_nw_attached_pd_0_b" {
  project     = var.project_id
  count       = length(var.instance_name_b)
  device_name = "${var.instance_name_b[count.index]}-${var.device_1}"
  disk        = element(google_compute_disk.gcp_nw_pd_0_b[count.index].*.self_link, count.index)
  instance    = google_compute_instance.gcp_nw_b[count.index].self_link

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_attached_disk" "gcp_nw_attached_pd_1_a" {
  project     = var.project_id
  count       = length(var.instance_name_a)
  device_name = "${var.instance_name_a[count.index]}-${var.device_2}"
  disk        = element(google_compute_disk.gcp_nw_pd_1_a[count.index].*.self_link, count.index)
  instance    = google_compute_instance.gcp_nw_a[count.index].self_link

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_attached_disk" "gcp_nw_attached_pd_1_b" {
  project     = var.project_id
  count       = length(var.instance_name_b)
  device_name = "${var.instance_name_b[count.index]}-${var.device_2}"
  disk        = element(google_compute_disk.gcp_nw_pd_1_b[count.index].*.self_link, count.index)
  instance    = google_compute_instance.gcp_nw_b[count.index].self_link

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_address" "internal_ip_a" {
  count        = length(var.instance_name_a)
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
  count        = length(var.instance_name_b)
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

data "google_compute_image" "image" {
  project = var.source_image_project
  name    = var.source_image_name
}

resource "google_compute_instance" "gcp_nw_a" {
  count                     = length(var.instance_name_a)
  project                   = var.project_id
  name                      = var.instance_name_a[count.index]
  machine_type              = var.instance_type
  zone                      = var.zone_a
  tags                      = var.network_tags
  allow_stopping_for_update = true
  can_ip_forward            = true
  deletion_protection       = false

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }

  boot_disk {
    auto_delete       = var.autodelete_disk
    device_name       = "${var.instance_name_a[count.index]}-${var.device_0}"
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
    network_ip         = var.instance_ip_a[count.index]
    dynamic "access_config" {
      for_each = [for i in [""] : i if var.use_public_ip]
      content {}
    }

  }

  metadata = {
    ssh-keys = "${var.ssh_user}:${file("${var.public_key_path}")}"
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

resource "google_compute_instance" "gcp_nw_b" {
  count                     = length(var.instance_name_b)
  project                   = var.project_id
  name                      = var.instance_name_b[count.index]
  machine_type              = var.instance_type
  zone                      = var.zone_b
  tags                      = var.network_tags
  allow_stopping_for_update = true
  can_ip_forward            = true
  deletion_protection       = false
  # metadata_startup_script   = file(var.startup_script)

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }

  boot_disk {
    auto_delete       = var.autodelete_disk
    device_name       = "${var.instance_name_b[count.index]}-${var.device_0}"
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
    network_ip         = var.instance_ip_b[count.index]
    dynamic "access_config" {
      for_each = [for i in [""] : i if var.use_public_ip]
      content {}
    }

  }

  metadata = {
    ssh-keys = "${var.ssh_user}:${file("${var.public_key_path}")}"
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

data "google_compute_instance" "sap_instance_a" {
  count   = length(var.instance_name_a)
  name    = google_compute_instance.gcp_nw_a[count.index].name
  project = var.project_id
  zone    = var.zone_a
}

data "google_compute_instance" "sap_instance_b" {
  count   = length(var.instance_name_b)
  name    = google_compute_instance.gcp_nw_b[count.index].name
  project = var.project_id
  zone    = var.zone_b
}