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

module "gcp_netweaver" {
  source                = "../../../terraform/modules/nw-standard-aas"
  project_id            = var.project_id
  subnetwork            = var.subnetwork_nw
  subnetwork_project    = var.subnetwork_project
  source_image_name     = var.source_image_name
  source_image_project  = var.source_image_project
  boot_disk_size        = var.sap_nw_boot_disk_size
  boot_disk_type        = var.sap_nw_boot_disk_type
  autodelete_disk       = var.sap_nw_autodelete_boot_disk
  use_public_ip         = var.sap_nw_use_public_ip
  usrsap_disk_size      = var.sap_nw_usrsap_disk_size
  swap_disk_size        = var.sap_nw_swap_disk_size
  usrsap_disk_type      = var.sap_nw_usrsap_disk_type
  swap_disk_type        = var.sap_nw_swap_disk_type
  instance_type         = var.sap_nw_instance_type
  instance_name_a       = var.sap_nw_aas_instance_name_a
  instance_name_b       = var.sap_nw_aas_instance_name_b
  instance_ip_a         = var.sap_nw_aas_instance_ip_a
  instance_ip_b         = var.sap_nw_aas_instance_ip_b
  region                = var.region
  zone_a                = var.zone_a
  zone_b                = var.zone_b
  network_tags          = var.sap_nw_network_tags
  service_account_email = var.sap_nw_service_account_email
  ssh_user              = var.gce_ssh_user
  public_key_path       = var.gce_ssh_pub_key_file
  startup_script        = var.nw_script_path
  pd_kms_key            = var.sap_nw_pd_kms_key
  labels                = var.sap_nw_aas_labels
}