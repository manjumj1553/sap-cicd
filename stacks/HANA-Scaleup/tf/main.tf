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

module "gcp_hana" {
  source                = "../../../terraform/modules/hana-scaleup-new-disk"
  project_id            = var.project_id
  subnetwork            = var.subnetwork
  subnetwork_project    = var.subnetwork_project
  source_image_name     = var.source_image_name
  source_image_project  = var.source_image_project
  gce_ssh_user          = var.gce_ssh_user
  gce_ssh_pub_key_file  = var.gce_ssh_pub_key_file
  zone                  = var.sap_zone
  instance_name         = var.sap_instance_name
  instance_ip           = var.sap_instance_ip
  instance_type         = var.sap_instance_type
  # use_public_ip         = var.sap_use_public_ip
  boot_disk_size        = var.sap_boot_disk_size
  boot_disk_type        = var.sap_boot_disk_type
  autodelete_disk       = var.sap_autodelete_boot_disk
  hana_data_size        = var.sap_data_disk_size
  log_disk_size         = var.sap_log_disk_size
  hana_shared_size      = var.sap_shared_disk_size
  hana_usr_size      = var.sap_usrsap_disk_size
  swap_disk_size        = var.sap_swap_disk_size
  # data_disk_type        = var.sap_data_disk_type
  # log_disk_type         = var.sap_log_disk_type
  # shared_disk_type      = var.sap_shared_disk_type
  # usrsap_disk_type      = var.sap_usrsap_disk_type
  # swap_disk_type        = var.sap_swap_disk_type
  hana_addon_disks      = var.sap_addon_disks
  service_account_email = var.sap_service_account_email
  network_tags          = var.sap_network_tags
  pd_kms_key            = var.sap_pd_kms_key
  labels                = var.sap_labels
  startup_script = var.hana_script_path
}