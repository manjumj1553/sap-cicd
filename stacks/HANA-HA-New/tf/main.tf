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

module "hana_ha_primary" {
  source                = "../../../terraform/modules/hana-ha-new"
  project_id            = var.project_id
  subnetwork            = var.subnetwork
  subnetwork_project    = var.subnetwork_project
  source_image_name     = var.source_image_name
  source_image_project  = var.source_image_project
  gce_ssh_user          = var.gce_ssh_user
  gce_ssh_pub_key_file  = var.gce_ssh_pub_key_file
  zone                  = var.sap_hana_primary_zone
  instance_name         = var.sap_hana_primary_instance_name
  instance_ip           = var.sap_hana_primary_instance_ip
  instance_type         = var.sap_hana_primary_instance_type
  boot_disk_size        = var.sap_hana_primary_boot_disk_size
  boot_disk_type        = var.sap_hana_primary_boot_disk_type
  autodelete_disk       = var.sap_hana_primary_autodelete_boot_disk
  data_disk_size        = var.sap_hana_primary_data_disk_size
  log_disk_size         = var.sap_hana_primary_log_disk_size
  shared_disk_size      = var.sap_hana_primary_shared_disk_size
  usrsap_disk_size      = var.sap_hana_primary_usrsap_disk_size
  swap_disk_size        = var.sap_hana_primary_swap_disk_size
  data_disk_type        = var.sap_hana_primary_data_disk_type
  log_disk_type         = var.sap_hana_primary_log_disk_type
  shared_disk_type      = var.sap_hana_primary_shared_disk_type
  usrsap_disk_type      = var.sap_hana_primary_usrsap_disk_type
  swap_disk_type        = var.sap_hana_primary_swap_disk_type
  hana_addon_disks      = var.sap_hana_primary_addon_disks
  service_account_email = var.sap_hana_primary_service_account_email
  network_tags          = var.sap_hana_primary_network_tags
  pd_kms_key            = var.sap_hana_primary_pd_kms_key
  labels                = var.sap_hana_primary_labels
  target_size           = 1
  is_primary            = "true"
  instance_group_name   = var.sap_hana_primary_instance_group_name
  named_ports           = var.sap_hana_primary_named_ports
}

module "hana_ha_secondary" {
  source                = "../../../terraform/modules/hana-ha-new"
  project_id            = var.project_id
  subnetwork            = var.subnetwork
  subnetwork_project    = var.subnetwork_project
  source_image_name     = var.source_image_name
  source_image_project  = var.source_image_project
  gce_ssh_user          = var.gce_ssh_user
  gce_ssh_pub_key_file  = var.gce_ssh_pub_key_file
  zone                  = var.sap_hana_secondary_zone
  instance_name         = var.sap_hana_secondary_instance_name
  instance_ip           = var.sap_hana_secondary_instance_ip
  instance_type         = var.sap_hana_secondary_instance_type
  boot_disk_size        = var.sap_hana_secondary_boot_disk_size
  boot_disk_type        = var.sap_hana_secondary_boot_disk_type
  autodelete_disk       = var.sap_hana_secondary_autodelete_boot_disk
  data_disk_size        = var.sap_hana_secondary_data_disk_size
  log_disk_size         = var.sap_hana_secondary_log_disk_size
  shared_disk_size      = var.sap_hana_secondary_shared_disk_size
  usrsap_disk_size      = var.sap_hana_secondary_usrsap_disk_size
  swap_disk_size        = var.sap_hana_secondary_swap_disk_size
  data_disk_type        = var.sap_hana_secondary_data_disk_type
  log_disk_type         = var.sap_hana_secondary_log_disk_type
  shared_disk_type      = var.sap_hana_secondary_shared_disk_type
  usrsap_disk_type      = var.sap_hana_secondary_usrsap_disk_type
  swap_disk_type        = var.sap_hana_secondary_swap_disk_type
  hana_addon_disks      = var.sap_hana_secondary_addon_disks
  service_account_email = var.sap_hana_secondary_service_account_email
  network_tags          = var.sap_hana_secondary_network_tags
  pd_kms_key            = var.sap_hana_secondary_pd_kms_key
  labels                = var.sap_hana_secondary_labels
  target_size           = 1
  is_primary            = "false"
  instance_group_name   = var.sap_hana_secondary_instance_group_name
  named_ports           = var.sap_hana_secondary_named_ports
}

module "sap_hana_ilb" {
  source               = "../../../terraform/modules/terraform-google-lb-internal"
  project              = var.project_id
  region               = local.region
  network              = local.network
  network_project      = var.network_project
  subnetwork           = var.subnetwork
  name                 = var.sap_hana_ilb_name
  source_tags          = ["source-tag"]
  target_tags          = ["target-tag"]
  ports                = null
  all_ports            = true
  health_check         = local.sap_hana_health_check
  ip_address           = var.sap_hana_ilb_ip_address
  health_check_name    = var.sap_hana_health_check_name
  backend_service_name = var.sap_hana_backend_service_name

  backends = [
    {
      group       = module.hana_ha_primary.instance_group_link
      description = "Primary instance backend group"
      failover    = false
    },
    {
      group       = module.hana_ha_secondary.instance_group_link
      description = "Secondary instance backend group"
      failover    = true
    },
  ]
}

data "google_compute_subnetwork" "subnetwork" {
  name    = var.subnetwork
  region  = local.region
  project = local.subnetwork_project
}