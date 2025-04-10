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

module "gcp_netweaver_webdisp_sa" {
  source                = "../../../../terraform/modules/wedisp-standalone"
  project_id            = var.project_id
  subnetwork            = var.subnetwork
  subnetwork_project    = var.subnetwork_project
  source_image_name     = var.source_image_name
  source_image_project  = var.source_image_project
  gce_ssh_user          = var.gce_ssh_user
  gce_ssh_pub_key_file  = var.gce_ssh_pub_key_file
  zone                  = var.sap_nw_zone
  instance_name         = var.sap_nw_instance_name
  instance_ip           = var.sap_nw_instance_ip
  instance_type         = var.sap_nw_instance_type
  boot_disk_size        = var.sap_nw_boot_disk_size
  boot_disk_type        = var.sap_nw_boot_disk_type
  autodelete_disk       = var.sap_nw_autodelete_boot_disk
  usrsap_disk_size      = var.sap_nw_usrsap_disk_size
  usrsap_disk_type      = var.sap_nw_usrsap_disk_type
  create_instance_group = var.sap_nw_create_instance_group
  instance_group_name   = var.sap_nw_instance_group_name
  service_account_email = var.sap_nw_service_account_email
  network_tags          = var.sap_nw_network_tags
  pd_kms_key            = var.sap_nw_pd_kms_key
  labels                = var.sap_nw_labels
  target_size           = 1
}