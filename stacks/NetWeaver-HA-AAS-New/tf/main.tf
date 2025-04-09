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

module "netweaver_aas" {
  source                = "../../../terraform/modules/nw-ha-aas-new"
  project_id            = var.project_id
  subnetwork            = var.subnetwork
  subnetwork_project    = local.subnetwork_project
  source_image_name     = var.source_image_name
  source_image_project  = var.source_image_project
  gce_ssh_user          = var.gce_ssh_user
  gce_ssh_pub_key_file  = var.gce_ssh_pub_key_file
  region                = var.sap_nw_aas_region
  zone_a                = var.sap_nw_aas_zone_a
  zone_b                = var.sap_nw_aas_zone_b
  instance_name_a       = var.sap_nw_aas_instance_name_a
  instance_name_b       = var.sap_nw_aas_instance_name_b
  instance_ip_a         = var.sap_nw_aas_instance_ip_a
  instance_ip_b         = var.sap_nw_aas_instance_ip_b
  instance_type         = var.sap_nw_aas_instance_type
  boot_disk_size        = var.sap_nw_aas_boot_disk_size
  boot_disk_type        = var.sap_nw_aas_boot_disk_type
  autodelete_disk       = var.sap_nw_aas_autodelete_boot_disk
  usrsap_disk_size      = var.sap_nw_aas_usrsap_disk_size
  swap_disk_size        = var.sap_nw_aas_swap_disk_size
  usrsap_disk_type      = var.sap_nw_aas_usrsap_disk_type
  swap_disk_type        = var.sap_nw_aas_swap_disk_type
  service_account_email = var.sap_nw_aas_service_account_email
  network_tags          = var.sap_nw_aas_network_tags
  pd_kms_key            = var.sap_nw_aas_pd_kms_key
  labels                = var.sap_nw_aas_labels
  create_instance_group = var.sap_nw_aas_create_instance_group
  instance_group_name   = var.sap_nw_aas_instance_group_name
  alias_ip_inp_a        = var.sap_nw_aas_alias_ip_a
  alias_ip_inp_b        = var.sap_nw_aas_alias_ip_b
  target_size_a         = length(var.sap_nw_aas_instance_ip_a)
  target_size_b         = length(var.sap_nw_aas_instance_ip_b)
  alias_ip_range = {
    ip_cidr_range = "/32"
  }
}