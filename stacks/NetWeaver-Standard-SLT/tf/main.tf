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
  source                = "../../../terraform/modules/nw-standard-slt"
  project_id            = var.project_id
  subnetwork            = var.subnetwork
  subnetwork_project    = var.subnetwork_project
  source_image_name     = var.source_image_name
  source_image_project  = var.source_image_project
  gce_ssh_user          = var.gce_ssh_user
  gce_ssh_pub_key_file  = var.gce_ssh_pub_key_file
  zone                  = var.zone
  instance_name         = var.sap_nw_instance_name
  instance_ip           = var.sap_nw_instance_ip
  instance_type         = var.sap_nw_instance_type
  use_public_ip         = var.sap_nw_use_public_ip
  boot_disk_size        = var.sap_nw_boot_disk_size
  boot_disk_type        = var.sap_nw_boot_disk_type
  autodelete_disk       = var.sap_nw_autodelete_boot_disk
  usrsap_disk_size      = var.sap_nw_usrsap_disk_size
  swap_disk_size        = var.sap_nw_swap_disk_size
  usrsap_disk_type      = var.sap_nw_usrsap_disk_type
  swap_disk_type        = var.sap_nw_swap_disk_type
  service_account_email = var.sap_nw_service_account_email
  network_tags          = var.sap_nw_network_tags
  pd_kms_key            = var.sap_nw_pd_kms_key
  labels                = var.sap_nw_labels
  alias_ip_inp          = var.sap_nw_alias_ip
  alias_ip_range = {
    ip_cidr_range = "/32"
  }
}