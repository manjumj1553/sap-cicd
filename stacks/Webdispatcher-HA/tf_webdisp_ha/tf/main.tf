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

module "gcp_netweaver_primary" {
  source                = "../../../../terraform/modules/wedisp-ha"
  subnetwork            = var.subnetwork_nw
  subnetwork_project    = var.subnetwork_project
  source_image_name     = var.source_image_name
  source_image_project  = var.source_image_project
  autodelete_disk       = var.sap_nw_autodelete_boot_disk
  use_public_ip         = var.sap_nw_use_public_ip
  usrsap_disk_size      = var.sap_nw_usrsap_disk_size
  instance_name         = var.sap_nw_primary_instance_name
  instance_ip           = var.sap_nw_primary_instance_ip
  instance_type         = var.sap_nw_instance_type
  network_tags          = var.sap_nw_network_tags
  project_id            = var.project_id
  zone                  = var.sap_nw_primary_zone
  target_size           = 1
  is_primary            = "true"
  boot_disk_size        = var.sap_nw_boot_disk_size
  boot_disk_type        = var.sap_nw_boot_disk_type
  additional_disk_type  = var.sap_nw_additional_disk_type
  service_account_email = var.sap_nw_service_account_email
  gce_ssh_user          = var.gce_ssh_user
  gce_ssh_pub_key_file  = var.gce_ssh_pub_key_file
  startup_script        = var.nw_script_path
  pd_kms_key            = var.sap_nw_pd_kms_key
  instance_group_name   = var.sap_nw_primary_instance_group_name
  labels                = var.sap_nw_primary_labels
}

module "gcp_netweaver_secondary" {
  source                = "../../../../terraform/modules/wedisp-ha"
  subnetwork            = var.subnetwork_nw
  subnetwork_project    = var.subnetwork_project
  source_image_name     = var.source_image_name
  source_image_project  = var.source_image_project
  autodelete_disk       = var.sap_nw_autodelete_boot_disk
  use_public_ip         = var.sap_nw_use_public_ip
  usrsap_disk_size      = var.sap_nw_usrsap_disk_size
  instance_name         = var.sap_nw_secondary_instance_name
  instance_ip           = var.sap_nw_secondary_instance_ip
  instance_type         = var.sap_nw_instance_type
  network_tags          = var.sap_nw_network_tags
  project_id            = var.project_id
  zone                  = var.sap_nw_secondary_zone
  target_size           = 1
  is_primary            = "false"
  boot_disk_size        = var.sap_nw_boot_disk_size
  boot_disk_type        = var.sap_nw_boot_disk_type
  additional_disk_type  = var.sap_nw_additional_disk_type
  service_account_email = var.sap_nw_service_account_email
  gce_ssh_user          = var.gce_ssh_user
  gce_ssh_pub_key_file  = var.gce_ssh_pub_key_file
  startup_script        = var.nw_script_path
  pd_kms_key            = var.sap_nw_pd_kms_key
  instance_group_name   = var.sap_nw_secondary_instance_group_name
  labels                = var.sap_nw_secondary_labels
}
