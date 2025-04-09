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

module "gcp_hana_scaleout" {
  source                = "../../../terraform/modules/hana-scaleout"
  project_id            = var.project_id
  subnetwork            = var.subnetwork
  subnetwork_project    = var.subnetwork_project
  source_image_name     = var.source_image_name
  source_image_project  = var.source_image_project
  gce_ssh_user          = var.gce_ssh_user
  gce_ssh_pub_key_file  = var.gce_ssh_pub_key_file
  zone                  = var.sap_hana_zone
  master_instance_name  = var.sap_hana_master_node_name
  worker_instance_names = var.sap_hana_worker_node_names
  master_instance_ip    = var.sap_hana_master_instance_ip
  worker_instance_ips   = var.sap_hana_worker_instance_ips
  instance_type         = var.sap_hana_instance_type
  use_public_ip         = var.sap_hana_use_public_ip
  boot_disk_size        = var.sap_hana_boot_disk_size
  boot_disk_type        = var.sap_hana_boot_disk_type
  autodelete_disk       = var.sap_hana_autodelete_boot_disk
  data_disk_size        = var.sap_hana_data_disk_size
  log_disk_size         = var.sap_hana_log_disk_size
  usrsap_disk_size      = var.sap_hana_usrsap_disk_size
  swap_disk_size        = var.sap_hana_swap_disk_size
  data_disk_type        = var.sap_hana_data_disk_type
  log_disk_type         = var.sap_hana_log_disk_type
  usrsap_disk_type      = var.sap_hana_usrsap_disk_type
  swap_disk_type        = var.sap_hana_swap_disk_type
  hana_addon_disks      = var.sap_hana_addon_disks
  service_account_email = var.sap_hana_service_account_email
  network_tags          = var.sap_hana_network_tags
  pd_kms_key            = var.sap_hana_pd_kms_key
  labels                = var.sap_hana_labels
  target_size           = length(var.sap_hana_worker_instance_ips)
}