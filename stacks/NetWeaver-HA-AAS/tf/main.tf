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

module "netweaver_aas" {
  source                = "../../../terraform/modules/nw-ha-aas"
  instance_name_a       = var.nw_aas_instance_name_a
  instance_name_b       = var.nw_aas_instance_name_b
  instance_ip_a         = var.nw_aas_instance_ip_a
  instance_ip_b         = var.nw_aas_instance_ip_b
  region                = var.region
  prefix                = var.prefix
  zone_a                = var.zone_a
  zone_b                = var.zone_b
  project_id            = var.project_id
  ssh_user              = var.gce_ssh_user
  public_key_path       = var.gce_ssh_pub_key_file
  subnetwork            = var.subnetwork_nw
  subnetwork_project    = local.subnetwork_project
  source_image_name     = var.source_nw_image_name
  source_image_project  = var.source_nw_image_project
  usr_sap_size          = var.nw_aas_usrsap_disk_size
  swap_size             = var.nw_aas_swap_disk_size
  instance_type         = var.nw_aas_instance_type
  boot_disk_size        = var.nw_aas_boot_disk_size
  boot_disk_type        = var.nw_aas_boot_disk_type
  usrsap_disk_type      = var.nw_aas_usrsap_disk_type
  swap_disk_type        = var.nw_aas_swap_disk_type
  autodelete_disk       = var.nw_autodelete_boot_disk
  network_tags          = var.nw_aas_network_tags
  service_account_email = var.nw_service_account_email
  target_size_a         = length(var.nw_aas_instance_ip_a)
  target_size_b         = length(var.nw_aas_instance_ip_b)
  create_instance_group = false
  instance_group_name   = ""
  alias_ip_range = {
    ip_cidr_range = "/32"
  }
  alias_ip_inp_a = var.nw_aas_alias_ip_a
  alias_ip_inp_b = var.nw_aas_alias_ip_b
  pd_kms_key     = var.nw_pd_kms_key
  labels         = var.nw_aas_labels
}

data "google_compute_subnetwork" "subnetwork_nw_a" {
  name    = var.subnetwork_nw
  region  = var.region
  project = local.subnetwork_project
}

data "google_compute_subnetwork" "subnetwork_nw_b" {
  name    = var.subnetwork_nw
  region  = var.region
  project = local.subnetwork_project
}


data "google_compute_instance" "aas_alias_ip_a" {
  count   = length(var.nw_aas_instance_ip_a)
  project = var.project_id
  name    = var.nw_aas_instance_name_a[count.index]
  zone    = var.zone_a
  depends_on = [
    module.netweaver_aas
  ]
}

data "google_compute_instance" "aas_alias_ip_b" {
  count   = length(var.nw_aas_instance_ip_b)
  project = var.project_id
  name    = var.nw_aas_instance_name_b[count.index]
  zone    = var.zone_b
  depends_on = [
    module.netweaver_aas
  ]
}