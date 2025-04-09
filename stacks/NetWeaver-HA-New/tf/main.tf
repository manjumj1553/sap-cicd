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

module "netweaver_ascs" {
  source                = "../../../terraform/modules/nw-ha-new"
  project_id            = var.project_id
  region                = local.region
  subnetwork            = var.subnetwork
  subnetwork_project    = local.subnetwork_project
  source_image_name     = var.source_image_name
  source_image_project  = var.source_image_project
  gce_ssh_user          = var.gce_ssh_user
  gce_ssh_pub_key_file  = var.gce_ssh_pub_key_file
  zone                  = var.primary_zone
  instance_name         = var.sap_nw_ascs_instance_name
  instance_ip           = var.sap_nw_ascs_instance_ip
  instance_type         = var.sap_nw_ascs_instance_type
  boot_disk_size        = var.sap_nw_ascs_boot_disk_size
  boot_disk_type        = var.sap_nw_ascs_boot_disk_type
  autodelete_disk       = var.sap_nw_ascs_autodelete_boot_disk
  usrsap_disk_size      = var.sap_nw_ascs_usrsap_disk_size
  swap_disk_size        = var.sap_nw_ascs_swap_disk_size
  usrsap_disk_type      = var.sap_nw_ascs_usrsap_disk_type
  swap_disk_type        = var.sap_nw_ascs_swap_disk_type
  service_account_email = var.sap_nw_ascs_service_account_email
  network_tags          = var.sap_nw_ascs_network_tags
  pd_kms_key            = var.sap_nw_ascs_pd_kms_key
  labels                = var.sap_nw_ascs_labels
  create_instance_group = var.sap_nw_ascs_create_instance_group
  instance_group_name   = var.sap_nw_ascs_instance_group_name
  alias_ip_inp          = var.sap_nw_ascs_alias_ip
  named_ports           = var.sap_nw_ascs_named_ports
}

module "netweaver_ers" {
  source                = "../../../terraform/modules/nw-ha-new"
  project_id            = var.project_id
  region                = local.region
  subnetwork            = var.subnetwork
  subnetwork_project    = local.subnetwork_project
  source_image_name     = var.source_image_name
  source_image_project  = var.source_image_project
  gce_ssh_user          = var.gce_ssh_user
  gce_ssh_pub_key_file  = var.gce_ssh_pub_key_file
  zone                  = var.secondary_zone
  instance_name         = var.sap_nw_ers_instance_name
  instance_ip           = var.sap_nw_ers_instance_ip
  instance_type         = var.sap_nw_ers_instance_type
  boot_disk_size        = var.sap_nw_ers_boot_disk_size
  boot_disk_type        = var.sap_nw_ers_boot_disk_type
  autodelete_disk       = var.sap_nw_ers_autodelete_boot_disk
  usrsap_disk_size      = var.sap_nw_ers_usrsap_disk_size
  swap_disk_size        = var.sap_nw_ers_swap_disk_size
  usrsap_disk_type      = var.sap_nw_ers_usrsap_disk_type
  swap_disk_type        = var.sap_nw_ers_swap_disk_type
  service_account_email = var.sap_nw_ers_service_account_email
  network_tags          = var.sap_nw_ers_network_tags
  pd_kms_key            = var.sap_nw_ers_pd_kms_key
  labels                = var.sap_nw_ers_labels
  create_instance_group = var.sap_nw_ers_create_instance_group
  instance_group_name   = var.sap_nw_ers_instance_group_name
  alias_ip_inp          = var.sap_nw_ers_alias_ip
  named_ports           = var.sap_nw_ers_named_ports
}

module "netweaver_pas" {
  source                = "../../../terraform/modules/nw-ha-new"
  project_id            = var.project_id
  region                = local.region
  subnetwork            = var.subnetwork
  subnetwork_project    = local.subnetwork_project
  source_image_name     = var.source_image_name
  source_image_project  = var.source_image_project
  gce_ssh_user          = var.gce_ssh_user
  gce_ssh_pub_key_file  = var.gce_ssh_pub_key_file
  zone                  = var.primary_zone
  instance_name         = var.sap_nw_pas_instance_name
  instance_ip           = var.sap_nw_pas_instance_ip
  instance_type         = var.sap_nw_pas_instance_type
  boot_disk_size        = var.sap_nw_pas_boot_disk_size
  boot_disk_type        = var.sap_nw_pas_boot_disk_type
  autodelete_disk       = var.sap_nw_pas_autodelete_boot_disk
  usrsap_disk_size      = var.sap_nw_pas_usrsap_disk_size
  swap_disk_size        = var.sap_nw_pas_swap_disk_size
  usrsap_disk_type      = var.sap_nw_pas_usrsap_disk_type
  swap_disk_type        = var.sap_nw_pas_swap_disk_type
  service_account_email = var.sap_nw_pas_service_account_email
  network_tags          = var.sap_nw_pas_network_tags
  pd_kms_key            = var.sap_nw_pas_pd_kms_key
  labels                = var.sap_nw_pas_labels
  create_instance_group = var.sap_nw_pas_create_instance_group
  instance_group_name   = var.sap_nw_pas_instance_group_name
  alias_ip_inp          = var.sap_nw_pas_alias_ip
  target_size           = 1
  alias_ip_range = {
    ip_cidr_range = "/32"
  }
}

module "ascs_ilb" {
  source               = "../../../terraform/modules/terraform-google-lb-internal"
  project              = var.project_id
  region               = local.region
  network              = local.network
  network_project      = var.network_project
  subnetwork           = var.subnetwork
  ilb_required         = local.ilb_required
  name                 = var.sap_nw_ascs_ilb_name
  source_tags          = ["soure-tag"]
  target_tags          = ["target-tag"]
  ports                = null
  all_ports            = true
  health_check         = local.sap_nw_ascs_health_check
  ip_address           = var.sap_nw_ascs_ilb_ip_address
  health_check_name    = var.sap_nw_ascs_health_check_name
  backend_service_name = var.sap_nw_ascs_backend_service_name
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
  region               = local.region
  network              = local.network
  network_project      = var.network_project
  subnetwork           = var.subnetwork
  ilb_required         = local.ilb_required
  name                 = var.sap_nw_ers_ilb_name
  source_tags          = ["soure-tag"]
  target_tags          = ["target-tag"]
  ports                = null
  all_ports            = true
  health_check         = local.sap_nw_ers_health_check
  ip_address           = var.sap_nw_ers_ilb_ip_address
  health_check_name    = var.sap_nw_ers_health_check_name
  backend_service_name = var.sap_nw_ers_backend_service_name
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

data "google_compute_subnetwork" "subnetwork" {
  name    = var.subnetwork
  region  = local.region
  project = local.subnetwork_project
}

data "google_compute_instance" "pas_alias_ip" {
  project = var.project_id
  name    = var.sap_nw_pas_instance_name
  zone    = var.primary_zone
  depends_on = [
    module.netweaver_pas
  ]
}