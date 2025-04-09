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

variable "ports" {
  default = null
}

variable "all_ports" {
  default = true
}

variable "project_id" {
  description = "The ID of the project in which the resources will be deployed."
  default     = ""
}

variable "ers_health_check_port" {
  description = "ers health check port."
}

variable "ascs_health_check_port" {
  description = "ascs health check port"
}

variable "subnetwork_nw" {
  description = "The name or self_link of the nw subnetwork where the isntance will be deployed. The subnetwork must exist in the same region this instance will be created in."
  default     = "app2"
}

variable "subnetwork_project" {
  description = "The name or self_link of the subnetwork project where the isntance will be deployed. The subnetwork must exist in the same region this instance will be created in."
  default     = ""
}

variable "ascs_instance_name" {
  description = "ASCS instance name"
}

variable "ascs_instance_ip" {
  description = "ASCS instance ip address"
}

variable "ers_instance_name" {
  description = "ERS instance name"
}

variable "ers_instance_ip" {
  description = "ERS instance ip address"
}

variable "pas_instance_name" {
  description = "PAS instance name"
}

variable "pas_instance_ip" {
  description = "PAS instance ip address"
}

variable "ascs_health_check_name" {
  description = "ASCS health check name"
}

variable "ers_health_check_name" {
  description = "ERS health check name"
}

variable "create_instance_group" {
  description = "If set to true, it will create instance group"
  type        = bool
  default     = true
}

variable "ascs_instance_group_name" {
  description = "ascs instance group name"
}

variable "ers_instance_group_name" {
  description = "ers instance group name"
}

variable "ers_ilb_ip" {
  description = "ERS internal loadbalancer ip"
}

variable "ascs_ilb_ip" {
  description = "ASCS internal loadbalancer ip"
}

variable "primary_zone" {
  description = "The zone that the primary instances should be created in."
}

variable "secondary_zone" {
  description = "The zone that the secondary instances should be created in."
}

variable "gce_ssh_user" {
  description = "SSH user name to connect to your instance."
}

variable "gce_ssh_pub_key_file" {
  description = "Path to the public SSH key you want to bake into the instance."
}

variable "nw_instance_type" {
  description = "The GCE instance/machine type for ASCS and ERS NetWeaver instances"
}

variable "nw_as_instance_type" {
  description = "The GCE instance/machine type for PAS NetWeaver instances"
}

variable "source_nw_image_name" {
  description = "GCE source_image name."
}

variable "source_nw_image_project" {
  description = "Project name containing the linux image."
}

variable "nw_network_tags" {
  type        = list(string)
  description = "List of network tags to attach to the NetWeaver instances."
}

variable "nw_boot_disk_size" {
  description = "Boot disk size in GB for NetWeaver."
  type        = number
}

variable "nw_boot_disk_type" {
  description = "Type of boot disk for NetWeaver."
}

variable "nw_usrsap_disk_type" {
  description = "Type of usrsap disk for NetWeaver ASCS/ERS."
}

variable "nw_swap_disk_type" {
  description = "Type of swap disk for NetWeaver ASCS/ERS."
}

variable "pas_boot_disk_type" {
  description = "Type of boot disk for NetWeaver PAS."
}

variable "pas_usrsap_disk_type" {
  description = "Type of usrsap disk for NetWeaver PAS."
}

variable "pas_swap_disk_type" {
  description = "Type of swap disk for NetWeaver PAS."
}

variable "nw_autodelete_boot_disk" {
  description = "Whether the NetWeaver boot disk will be auto-deleted when the instance is deleted."
}

variable "nw_usrsap_disk_size" {
  description = "Persistent disk size in GB"
  type        = number
}

variable "nw_pas_usrsap_disk_size" {
  description = "Persistent disk size in GB"
  type        = number
}

variable "nw_swap_disk_size" {
  description = "Persistent disk size in GB."
  type        = number
}

variable "nw_pas_swap_disk_size" {
  description = "Persistent disk size in GB."
  type        = number
}

variable "nw_service_account_email" {
  description = "Email of service account to attach to the instance."
}

variable "ascs_ilb_name" {
  description = "ASCS ilb name"
}

variable "ers_ilb_name" {
  description = "ERS ilb name"
}

variable "ascs_backend_service_name" {
  description = "ascs backend service name"
}

variable "ers_backend_service_name" {
  description = "ers backend service name"
}

variable "nw_script_path" {
  description = "netweaver startup script path"
}

variable "hana_script_path" {
  description = "hana startup script path"
}

variable "pas_alias_ip" {
  description = "PAS Instance alias IP."
}

variable "nw_pd_kms_key" {
  description = "Customer managed encryption key to use in persistent disks. If none provided, a Google managed key will be used.."
}

variable "nw_ascs_labels" {
  description = "List of labels to attach to the ASCS NetWeaver instance."
  default     = {}
}

variable "nw_ers_labels" {
  description = "List of labels to attach to the ERS NetWeaver instance."
  default     = {}
}

variable "nw_pas_labels" {
  description = "List of labels to attach to the PAS NetWeaver instance."
  default     = {}
}