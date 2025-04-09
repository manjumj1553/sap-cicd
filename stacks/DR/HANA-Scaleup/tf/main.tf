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
  source                = "../../../../terraform/modules/dr/hana-scaleup-new-disk"
  project_id            = var.project_id
  subnetwork            = var.subnetwork
  subnetwork_project    = var.subnetwork_project
  source_image_name     = var.source_image_name
  source_image_project  = var.source_image_project
  gce_ssh_user          = var.gce_ssh_user
  gce_ssh_pub_key_file  = var.gce_ssh_pub_key_file
  zone                  = var.sap_hana_dr_zone
  instance_name         = var.sap_hana_dr_instance_name
  instance_ip           = var.sap_hana_dr_instance_ip
  instance_type         = var.sap_hana_dr_instance_type
  use_public_ip         = var.sap_hana_dr_use_public_ip
  boot_disk_size        = var.sap_hana_dr_boot_disk_size
  boot_disk_type        = var.sap_hana_dr_boot_disk_type
  autodelete_disk       = var.sap_hana_dr_autodelete_boot_disk
  data_disk_size        = var.sap_hana_dr_data_disk_size
  log_disk_size         = var.sap_hana_dr_log_disk_size
  shared_disk_size      = var.sap_hana_dr_shared_disk_size
  usrsap_disk_size      = var.sap_hana_dr_usrsap_disk_size
  swap_disk_size        = var.sap_hana_dr_swap_disk_size
  data_disk_type        = var.sap_hana_dr_data_disk_type
  log_disk_type         = var.sap_hana_dr_log_disk_type
  shared_disk_type      = var.sap_hana_dr_shared_disk_type
  usrsap_disk_type      = var.sap_hana_dr_usrsap_disk_type
  swap_disk_type        = var.sap_hana_dr_swap_disk_type
  hana_addon_disks      = var.sap_hana_dr_addon_disks
  service_account_email = var.sap_hana_dr_service_account_email
  network_tags          = var.sap_hana_dr_network_tags
  pd_kms_key            = var.sap_hana_dr_pd_kms_key
  labels                = var.sap_hana_dr_labels
}