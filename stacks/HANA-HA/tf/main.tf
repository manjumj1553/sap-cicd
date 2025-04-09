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

provider "google" {
}

module "hana_ha_primary" {
  source                = "../../../terraform/modules/hana-ha"
  instance_name         = var.sap_hana_primary_instance_name
  instance_ip           = var.sap_hana_primary_instance_ip
  instance_type         = var.sap_hana_instance_type
  project_id            = var.project_id
  zone                  = var.sap_hana_primary_zone
  gce_ssh_user          = var.gce_ssh_user
  gce_ssh_pub_key_file  = var.gce_ssh_pub_key_file
  service_account_email = var.sap_hana_service_account_email
  subnetwork            = var.subnetwork_hana
  subnetwork_project    = var.subnetwork_project
  source_image_name     = var.source_image_name
  source_image_project  = var.source_image_project
  boot_disk_size        = var.sap_hana_boot_disk_size
  boot_disk_type        = var.sap_hana_boot_disk_type
  additional_disk_type  = var.sap_hana_additional_disk_type
  autodelete_disk       = var.sap_hana_autodelete_boot_disk
  network_tags          = var.sap_hana_network_tags
  pd_kms_key            = var.sap_hana_pd_kms_key
  hana_log_size         = var.sap_hana_log_size
  hana_data_size        = var.sap_hana_data_size
  hana_shared_size      = var.sap_hana_shared_size
  hana_usr_size         = var.sap_hana_usr_size
  hana_swap_size        = var.sap_hana_swap_size
  hana_log_disk_type    = var.sap_hana_log_disk_type
  hana_data_disk_type   = var.sap_hana_data_disk_type
  hana_shared_disk_type = var.sap_hana_shared_disk_type
  hana_usr_disk_type    = var.sap_hana_usr_disk_type
  hana_swap_disk_type   = var.sap_hana_swap_disk_type
  target_size           = 1
  is_primary            = "true"
  instance_group_name   = var.primary_instance_group_name
  labels                = var.sap_hana_primary_labels
  hana_addon_disks      = var.sap_hana_addon_disks
}

module "hana_ha_secondary" {
  source                = "../../../terraform/modules/hana-ha"
  instance_name         = var.sap_hana_secondary_instance_name
  instance_ip           = var.sap_hana_secondary_instance_ip
  instance_type         = var.sap_hana_instance_type
  project_id            = var.project_id
  zone                  = var.sap_hana_secondary_zone
  gce_ssh_user          = var.gce_ssh_user
  gce_ssh_pub_key_file  = var.gce_ssh_pub_key_file
  service_account_email = var.sap_hana_service_account_email
  subnetwork            = var.subnetwork_hana
  subnetwork_project    = var.subnetwork_project
  source_image_name     = var.source_image_name
  source_image_project  = var.source_image_project
  boot_disk_size        = var.sap_hana_boot_disk_size
  boot_disk_type        = var.sap_hana_boot_disk_type
  additional_disk_type  = var.sap_hana_additional_disk_type
  autodelete_disk       = var.sap_hana_autodelete_boot_disk
  network_tags          = var.sap_hana_network_tags
  pd_kms_key            = var.sap_hana_pd_kms_key
  hana_log_size         = var.sap_hana_log_size
  hana_data_size        = var.sap_hana_data_size
  hana_shared_size      = var.sap_hana_shared_size
  hana_usr_size         = var.sap_hana_usr_size
  hana_swap_size        = var.sap_hana_swap_size
  hana_log_disk_type    = var.sap_hana_log_disk_type
  hana_data_disk_type   = var.sap_hana_data_disk_type
  hana_shared_disk_type = var.sap_hana_shared_disk_type
  hana_usr_disk_type    = var.sap_hana_usr_disk_type
  hana_swap_disk_type   = var.sap_hana_swap_disk_type
  target_size           = 1
  is_primary            = "false"
  instance_group_name   = var.secondary_instance_group_name
  labels                = var.sap_hana_secondary_labels
  hana_addon_disks      = var.sap_hana_addon_disks
}

module "sap_hana_ilb" {
  source               = "../../../terraform/modules/terraform-google-lb-internal"
  project              = var.project_id
  region               = local.region
  network              = local.network
  network_project      = var.subnetwork_project
  subnetwork           = var.subnetwork_hana
  name                 = var.hana_ilb_name
  source_tags          = ["source-tag"]
  target_tags          = ["target-tag"]
  ports                = null
  all_ports            = true
  health_check         = local.health_check
  ip_address           = var.hana_ilb_ip_address
  health_check_name    = var.hana_health_check_name
  backend_service_name = var.backend_service_name

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
data "google_compute_subnetwork" "subnetwork_hana" {
  name    = var.subnetwork_hana
  region  = local.region
  project = local.subnetwork_project
}
