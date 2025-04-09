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

variable "project_id" {
  description = "The ID of the project in which the resources will be deployed."
  default     = ""
}

variable "subnetwork_nw" {
  description = "The name or self_link of the nw subnetwork where the isntance will be deployed. The subnetwork must exist in the same region this instance will be created in."
  default     = "app2"
}

variable "subnetwork_project" {
  description = "The name or self_link of the subnetwork project where the isntance will be deployed. The subnetwork must exist in the same region this instance will be created in."
  default     = ""
}

variable "nw_aas_instance_name_a" {
  description = "AAS instance name in zone_a"
}

variable "nw_aas_instance_name_b" {
  description = "AAS instance name in zone_b"
}

variable "nw_aas_instance_ip_a" {
  description = "AAS instance ip address in zone_a"
  type        = list(string)
}

variable "nw_aas_instance_ip_b" {
  description = "AAS instance ip address in zone_b"
  type        = list(string)
}

variable "region" {
  description = "Region to deploy the resources. Should be in the same region as the zone."
  default     = "us-central1"
}

variable "zone_a" {
  description = "The zone_a that the NetWeaver-HA-AAS instances should be created in."
}

variable "zone_b" {
  description = "The zone_b that the NetWeaver-HA-AAS instances should be created in."
}

variable "gce_ssh_user" {
  description = "SSH user name to connect to your instance."
}

variable "gce_ssh_pub_key_file" {
  description = "Path to the public SSH key you want to bake into the instance."
}

variable "nw_aas_instance_type" {
  description = "The GCE instance/machine type for PAS NetWeaver instances"
}

variable "source_nw_image_name" {
  description = "GCE linux image name."
}

variable "source_nw_image_project" {
  description = "Project name containing the linux image."
}

variable "nw_aas_network_tags" {
  type        = list(string)
  description = "List of network tags to attach to the NetWeaver instances."
}

variable "nw_aas_boot_disk_size" {
  description = "Boot disk size in GB for NetWeaver."
  type        = number
}

variable "nw_autodelete_boot_disk" {
  description = "Whether the NetWeaver boot disk will be auto-deleted when the instance is deleted."
}

variable "nw_aas_usrsap_disk_size" {
  description = "Persistent disk size in GB"
  type        = number
}

variable "nw_aas_swap_disk_size" {
  description = "Persistent disk size in GB."
  type        = number
}

variable "nw_service_account_email" {
  description = "Email of service account to attach to the instance."
}

variable "nw_script_path" {
  description = "netweaver startup script path"
}

variable "hana_script_path" {
  description = "hana startup script path"
}

variable "nw_aas_alias_ip_a" {
  description = "Netweaver AAS instance alias ip for zone_a"
  type        = list(string)
}

variable "nw_aas_alias_ip_b" {
  description = "Netweaver AAS instance alias ip for zone_b."
  type        = list(string)
}

variable "nw_aas_boot_disk_type" {
  description = "Netweaver AAS instance boot disk type"
}

variable "nw_aas_usrsap_disk_type" {
  description = "Netweaver AAS instance usrsap disk type"
}

variable "nw_aas_swap_disk_type" {
  description = "Netweaver AAS instance swap disk type"
}

variable "nw_pd_kms_key" {
  description = "Customer managed encryption key to use in persistent disks. If none provided, a Google managed key will be used.."
}

variable "nw_aas_labels" {
  description = "List of labels to attach to the Netweaver AAS instance."
  default     = {}
}

variable "prefix" {
  description = "Prefix for Netweaver AAS instance template."
}
