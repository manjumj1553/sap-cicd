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
  disk_combinations = flatten([
    for instance_name in var.worker_instance_names : [
      for i, disk_name in var.hana_addon_disks.name : {
        instance_name = instance_name
        disk_name     = "${instance_name}-${disk_name}"
        disk_size_gb  = var.hana_addon_disks.disk_size_gb[i]
        disk_type     = var.hana_addon_disks.disk_type[i]
        device_name   = "${instance_name}-${disk_name}"
      }
    ]
  ])
}

data "google_compute_subnetwork" "subnetwork" {
  name    = var.subnetwork
  region  = local.region
  project = local.subnetwork_project
}

data "google_compute_image" "image" {
  project = var.source_image_project
  name    = var.source_image_name
}

resource "google_compute_address" "gcp_sap_hana_intip_master" {
  name         = var.master_instance_name
  address_type = "INTERNAL"
  subnetwork   = "projects/${local.subnetwork_project}/regions/${local.region}/subnetworks/${var.subnetwork}"
  region       = local.region
  project      = var.project_id
  purpose      = "GCE_ENDPOINT"
  address      = var.master_instance_ip

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_address" "gcp_sap_hana_intip_worker" {
  count        = var.target_size
  name         = var.worker_instance_names[count.index]
  address_type = "INTERNAL"
  subnetwork   = "projects/${local.subnetwork_project}/regions/${local.region}/subnetworks/${var.subnetwork}"
  region       = local.region
  project      = var.project_id
  purpose      = "GCE_ENDPOINT"
  address      = var.worker_instance_ips[count.index]

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_instance" "gcp_hana_master" {
  project                   = var.project_id
  name                      = var.master_instance_name
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
    device_name       = "${var.master_instance_name}-${var.device_boot}"
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
    network_ip         = google_compute_address.gcp_sap_hana_intip_master.address
    dynamic "access_config" {
      for_each = [for i in [""] : i if var.use_public_ip]
      content {}
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

resource "google_compute_instance" "gcp_hana_worker" {
  count                     = var.target_size
  project                   = var.project_id
  name                      = var.worker_instance_names[count.index]
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
    device_name       = "${var.worker_instance_names[count.index]}-${var.device_boot}"
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
    network_ip         = google_compute_address.gcp_sap_hana_intip_worker[count.index].address
    dynamic "access_config" {
      for_each = [for i in [""] : i if var.use_public_ip]
      content {}
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

resource "google_compute_disk" "gcp_sap_hana_data_master" {
  project = var.project_id
  name    = "${var.master_instance_name}-${var.device_data}"
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

resource "google_compute_disk" "gcp_sap_hana_data_worker" {
  count   = var.target_size
  project = var.project_id
  name    = "${var.worker_instance_names[count.index]}-${var.device_data}"
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

resource "google_compute_disk" "gcp_sap_hana_log_master" {
  project = var.project_id
  name    = "${var.master_instance_name}-${var.device_log}"
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

resource "google_compute_disk" "gcp_sap_hana_log_worker" {
  count   = var.target_size
  project = var.project_id
  name    = "${var.worker_instance_names[count.index]}-${var.device_log}"
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

resource "google_compute_disk" "gcp_sap_hana_usrsap_master" {
  project = var.project_id
  name    = "${var.master_instance_name}-${var.device_usrsap}"
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

resource "google_compute_disk" "gcp_sap_hana_usrsap_worker" {
  count   = var.target_size
  project = var.project_id
  name    = "${var.worker_instance_names[count.index]}-${var.device_usrsap}"
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

resource "google_compute_disk" "gcp_sap_hana_swap_master" {
  project = var.project_id
  name    = "${var.master_instance_name}-${var.device_swap}"
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

resource "google_compute_disk" "gcp_sap_hana_swap_worker" {
  count   = var.target_size
  project = var.project_id
  name    = "${var.worker_instance_names[count.index]}-${var.device_swap}"
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

resource "google_compute_disk" "gcp_sap_hana_addon_disks_master" {
  count   = length(var.hana_addon_disks.name)
  project = var.project_id
  name    = "${var.master_instance_name}-${var.hana_addon_disks.name[count.index]}"
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

resource "google_compute_disk" "gcp_sap_hana_addon_disks_worker" {
  for_each = { for disk in local.disk_combinations : disk.disk_name => disk }

  project = var.project_id
  name    = each.value.disk_name
  type    = each.value.disk_type
  zone    = var.zone
  size    = each.value.disk_size_gb

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

resource "google_compute_attached_disk" "gcp_sap_hana_attached_data_master" {
  project     = var.project_id
  zone        = var.zone
  disk        = google_compute_disk.gcp_sap_hana_data_master.self_link
  instance    = google_compute_instance.gcp_hana_master.self_link
  device_name = "${var.master_instance_name}-${var.device_data}"
  depends_on  = [google_compute_disk.gcp_sap_hana_data_master]

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_attached_disk" "gcp_sap_hana_attached_data_worker" {
  count       = var.target_size
  project     = var.project_id
  zone        = var.zone
  disk        = google_compute_disk.gcp_sap_hana_data_worker[count.index].self_link
  instance    = google_compute_instance.gcp_hana_worker[count.index].self_link
  device_name = "${var.worker_instance_names[count.index]}-${var.device_data}"
  depends_on  = [google_compute_disk.gcp_sap_hana_data_worker]

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_attached_disk" "gcp_sap_hana_attached_log_master" {
  project     = var.project_id
  zone        = var.zone
  disk        = google_compute_disk.gcp_sap_hana_log_master.self_link
  instance    = google_compute_instance.gcp_hana_master.self_link
  device_name = "${var.master_instance_name}-${var.device_log}"
  depends_on  = [google_compute_disk.gcp_sap_hana_log_master]

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_attached_disk" "gcp_sap_hana_attached_log_worker" {
  count       = var.target_size
  project     = var.project_id
  zone        = var.zone
  disk        = google_compute_disk.gcp_sap_hana_log_worker[count.index].self_link
  instance    = google_compute_instance.gcp_hana_worker[count.index].self_link
  device_name = "${var.worker_instance_names[count.index]}-${var.device_log}"
  depends_on  = [google_compute_disk.gcp_sap_hana_log_worker]

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_attached_disk" "gcp_sap_hana_attached_usrsap_master" {
  project     = var.project_id
  zone        = var.zone
  disk        = google_compute_disk.gcp_sap_hana_usrsap_master.self_link
  instance    = google_compute_instance.gcp_hana_master.self_link
  device_name = "${var.master_instance_name}-${var.device_usrsap}"
  depends_on  = [google_compute_disk.gcp_sap_hana_usrsap_master]

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_attached_disk" "gcp_sap_hana_attached_usrsap_worker" {
  count       = var.target_size
  project     = var.project_id
  zone        = var.zone
  disk        = google_compute_disk.gcp_sap_hana_usrsap_worker[count.index].self_link
  instance    = google_compute_instance.gcp_hana_worker[count.index].self_link
  device_name = "${var.worker_instance_names[count.index]}-${var.device_usrsap}"
  depends_on  = [google_compute_disk.gcp_sap_hana_usrsap_worker]

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_attached_disk" "gcp_sap_hana_attached_swap_master" {
  project     = var.project_id
  zone        = var.zone
  disk        = google_compute_disk.gcp_sap_hana_swap_master.self_link
  instance    = google_compute_instance.gcp_hana_master.self_link
  device_name = "${var.master_instance_name}-${var.device_swap}"
  depends_on  = [google_compute_disk.gcp_sap_hana_swap_master]

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_attached_disk" "gcp_sap_hana_attached_swap_worker" {
  count       = var.target_size
  project     = var.project_id
  zone        = var.zone
  disk        = google_compute_disk.gcp_sap_hana_swap_worker[count.index].self_link
  instance    = google_compute_instance.gcp_hana_worker[count.index].self_link
  device_name = "${var.worker_instance_names[count.index]}-${var.device_swap}"
  depends_on  = [google_compute_disk.gcp_sap_hana_swap_worker]

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_attached_disk" "gcp_sap_hana_attached_addon_disks_master" {
  count       = length(var.hana_addon_disks.name)
  project     = var.project_id
  zone        = var.zone
  disk        = google_compute_disk.gcp_sap_hana_addon_disks_master[count.index].self_link
  instance    = google_compute_instance.gcp_hana_master.self_link
  device_name = "${var.master_instance_name}-${var.hana_addon_disks.name[count.index]}"
  depends_on  = [google_compute_disk.gcp_sap_hana_addon_disks_master]

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_attached_disk" "gcp_sap_hana_attached_addon_disks_worker" {
  for_each = { for disk in local.disk_combinations : disk.disk_name => disk }

  project     = var.project_id
  zone        = var.zone
  disk        = google_compute_disk.gcp_sap_hana_addon_disks_worker[each.key].id
  # disk        = google_compute_disk.gcp_sap_hana_addon_disks_worker[each.key].self_link
  instance    = each.value.instance_name
  device_name = each.value.device_name
  depends_on  = [google_compute_disk.gcp_sap_hana_addon_disks_worker, google_compute_instance.gcp_hana_worker]

  lifecycle {
    create_before_destroy = true
  }
}