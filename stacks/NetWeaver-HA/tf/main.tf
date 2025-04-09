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

module "netweaver_ascs" {
  source                = "../../../terraform/modules/nw-ha"
  instance_name         = var.ascs_instance_name
  instance_ip           = var.ascs_instance_ip
  zone                  = var.primary_zone
  ssh_user              = var.gce_ssh_user
  project_id            = var.project_id
  public_key_path       = var.gce_ssh_pub_key_file
  region                = local.region
  subnetwork            = var.subnetwork_nw
  subnetwork_project    = local.subnetwork_project
  source_image_name     = var.source_nw_image_name
  source_image_project  = var.source_nw_image_project
  usr_sap_size          = var.nw_usrsap_disk_size
  swap_size             = var.nw_swap_disk_size
  instance_type         = var.nw_instance_type
  boot_disk_size        = var.nw_boot_disk_size
  boot_disk_type        = var.nw_boot_disk_type
  usrsap_disk_type      = var.nw_usrsap_disk_type
  swap_disk_type        = var.nw_swap_disk_type
  autodelete_disk       = var.nw_autodelete_boot_disk
  network_tags          = var.nw_network_tags
  service_account_email = var.nw_service_account_email
  create_instance_group = var.create_instance_group
  instance_group_name   = var.ascs_instance_group_name
  alias_ip_inp          = ""
  pd_kms_key            = var.nw_pd_kms_key
  labels                = var.nw_ascs_labels
}

module "netweaver_ers" {
  source                = "../../../terraform/modules/nw-ha"
  instance_name         = var.ers_instance_name
  instance_ip           = var.ers_instance_ip
  zone                  = var.secondary_zone
  project_id            = var.project_id
  ssh_user              = var.gce_ssh_user
  public_key_path       = var.gce_ssh_pub_key_file
  region                = local.region
  subnetwork            = var.subnetwork_nw
  subnetwork_project    = local.subnetwork_project
  source_image_name     = var.source_nw_image_name
  source_image_project  = var.source_nw_image_project
  usr_sap_size          = var.nw_usrsap_disk_size
  swap_size             = var.nw_swap_disk_size
  instance_type         = var.nw_instance_type
  boot_disk_size        = var.nw_boot_disk_size
  boot_disk_type        = var.nw_boot_disk_type
  usrsap_disk_type      = var.nw_usrsap_disk_type
  swap_disk_type        = var.nw_swap_disk_type
  autodelete_disk       = var.nw_autodelete_boot_disk
  network_tags          = var.nw_network_tags
  service_account_email = var.nw_service_account_email
  create_instance_group = var.create_instance_group
  instance_group_name   = var.ers_instance_group_name
  alias_ip_inp          = ""
  pd_kms_key            = var.nw_pd_kms_key
  labels                = var.nw_ers_labels
}

module "netweaver_as" {
  source                = "../../../terraform/modules/nw-ha"
  instance_name         = var.pas_instance_name
  instance_ip           = var.pas_instance_ip
  zone                  = var.primary_zone
  project_id            = var.project_id
  ssh_user              = var.gce_ssh_user
  public_key_path       = var.gce_ssh_pub_key_file
  region                = local.region
  subnetwork            = var.subnetwork_nw
  subnetwork_project    = local.subnetwork_project
  source_image_name     = var.source_nw_image_name
  source_image_project  = var.source_nw_image_project
  instance_type         = var.nw_as_instance_type
  boot_disk_size        = var.nw_boot_disk_size
  boot_disk_type        = var.pas_boot_disk_type
  usr_sap_size          = var.nw_pas_usrsap_disk_size
  swap_size             = var.nw_pas_swap_disk_size
  usrsap_disk_type      = var.pas_usrsap_disk_type
  swap_disk_type        = var.pas_swap_disk_type
  autodelete_disk       = var.nw_autodelete_boot_disk
  network_tags          = var.nw_network_tags
  service_account_email = var.nw_service_account_email
  target_size           = 1
  create_instance_group = false
  instance_group_name   = ""
  alias_ip_range = {
    ip_cidr_range = "/32"
  }
  alias_ip_inp = var.pas_alias_ip
  pd_kms_key   = var.nw_pd_kms_key
  labels       = var.nw_pas_labels
}

module "ascs_ilb" {
  source               = "../../../terraform/modules/terraform-google-lb-internal"
  project              = var.project_id
  network_project      = local.subnetwork_project
  region               = local.region
  network              = local.network_nw
  subnetwork           = var.subnetwork_nw
  name                 = var.ascs_ilb_name
  source_tags          = ["soure-tag"]
  target_tags          = ["target-tag"]
  ports                = var.ports
  all_ports            = var.all_ports
  health_check         = local.ascs_health_check
  ip_address           = var.ascs_ilb_ip
  health_check_name    = var.ascs_health_check_name
  backend_service_name = var.ascs_backend_service_name
  backends = [
    {
      group       = module.netweaver_ascs.umig_self_link
      description = "Primary instance backend group"
      failover    = false
    },
    {
      group       = module.netweaver_ers.umig_self_link
      description = "failover instance backend group"
      failover    = true
    }
  ]
}

module "ers_ilb" {
  source               = "../../../terraform/modules/terraform-google-lb-internal"
  project              = var.project_id
  network_project      = local.subnetwork_project
  region               = local.region
  network              = local.network_nw
  ilb_required         = local.ilb_required
  subnetwork           = var.subnetwork_nw
  name                 = var.ers_ilb_name
  source_tags          = ["soure-tag"]
  target_tags          = ["target-tag"]
  ports                = var.ports
  all_ports            = var.all_ports
  health_check         = local.ers_health_check
  ip_address           = var.ers_ilb_ip
  health_check_name    = var.ers_health_check_name
  backend_service_name = var.ers_backend_service_name
  backends = [
    {
      group       = module.netweaver_ers.umig_self_link
      description = "Primary instance backend group"
      failover    = false
    },
    {
      group       = module.netweaver_ascs.umig_self_link
      description = "failover instance backend group"
      failover    = true
    }
  ]
}

data "google_compute_subnetwork" "subnetwork_nw" {
  name    = var.subnetwork_nw
  region  = local.region
  project = local.subnetwork_project
}

data "google_compute_instance" "pas_alias_ip" {
  project = var.project_id
  name    = var.pas_instance_name
  zone    = var.primary_zone
  depends_on = [
    module.netweaver_as
  ]
}
