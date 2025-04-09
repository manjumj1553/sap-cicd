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
  description = "GCP project ID for resource deployment."
}

variable "subnetwork" {
  description = "Name or self-link of the subnetwork for instance deployment. Must reside in the instance's region."
  default     = "app2"
}

variable "subnetwork_project" {
  description = "Name or self-link of the subnetwork's project. Must reside in the instance's region."
}

variable "source_image_name" {
  description = "Name of the GCE source image."
}

variable "source_image_project" {
  description = "GCP project containing the source image."
  default     = "rhel-sap-cloud"
}

variable "gce_ssh_user" {
  description = "Username for SSH access to the GCE instance."
}

variable "gce_ssh_pub_key_file" {
  description = "Path to the SSH public key file for authentication."
  default     = "~/.ssh/id_rsa.pub"
}

variable "primary_zone" {
  description = "GCP primary zone for instance deployment."
  default     = "us-central1-a"
}

variable "secondary_zone" {
  description = "GCP secondary zone for instance deployment."
  default     = "us-central1-b"
}

##ASCS Variables
variable "sap_nw_ascs_instance_name" {
  description = "Name of the NetWeaver ASCS instance. Changing this will create a new instance."
}

variable "sap_nw_ascs_instance_ip" {
  description = "Static IP address for the NetWeaver ASCS instance. Changing this will create a new instance."
}

variable "sap_nw_ascs_instance_type" {
  description = "GCP instance/machine type for the NetWeaver ASCS instance."
  default     = "n1-highmem-32"
}

variable "sap_nw_ascs_boot_disk_size" {
  description = "Size of the NetWeaver ASCS boot disk in GB."
  default     = 30
}

variable "sap_nw_ascs_boot_disk_type" {
  description = "Type of the NetWeaver ASCS boot disk. Set to pd-standard (for PD HDD)."
  default     = "pd-ssd"
}

variable "sap_nw_ascs_autodelete_boot_disk" {
  description = "Whether to auto-delete the boot disk when the instance is deleted."
}

variable "sap_nw_ascs_usrsap_disk_size" {
  description = "Size of the NetWeaver ASCS usrsap disk in GB."
}

variable "sap_nw_ascs_swap_disk_size" {
  description = "Size of the NetWeaver ASCS swap disk in GB."
}

variable "sap_nw_ascs_usrsap_disk_type" {
  description = "Type of the NetWeaver ASCS usrsap disk."
  default     = "pd-ssd"
}

variable "sap_nw_ascs_swap_disk_type" {
  description = "Type of the NetWeaver ASCS swap disk."
  default     = "pd-ssd"
}

variable "sap_nw_ascs_service_account_email" {
  description = "Email address of the service account to attach to the NetWeaver ASCS instance."
}

variable "sap_nw_ascs_network_tags" {
  description = "List of network tags for the NetWeaver ASCS instance."
  type        = list(string)
  default     = []
}

variable "sap_nw_ascs_pd_kms_key" {
  description = "KMS key for encrypting persistent disks. Uses Google-managed key if not provided."
}

variable "sap_nw_ascs_labels" {
  description = "Labels to apply to the NetWeaver ASCS instance."
  default     = {}
}

variable "sap_nw_ascs_create_instance_group" {
  description = "Whether to create the NetWeaver ASCS instance group."
  type        = bool
  default     = true
}

variable "sap_nw_ascs_instance_group_name" {
  description = "Name of the primary NetWeaver ASCS instance group."
}

variable "sap_nw_ascs_alias_ip" {
  description = "Alias IP address for the ASCS instance (optional)."
  default     = ""
}

variable "sap_nw_ascs_named_ports" {
  type = list(object({
    name = string
    port = number
  }))
  description = "List of named ports for the ASCS instance."
  default     = []
}

##ERS Variables
variable "sap_nw_ers_instance_name" {
  description = "Name of the NetWeaver ERS instance. Changing this will create a new instance."
}

variable "sap_nw_ers_instance_ip" {
  description = "Static IP address for the NetWeaver ERS instance. Changing this will create a new instance."
}

variable "sap_nw_ers_instance_type" {
  description = "GCP instance/machine type for the NetWeaver ERS instance."
  default     = "n1-highmem-32"
}

variable "sap_nw_ers_boot_disk_size" {
  description = "Size of the NetWeaver ERS boot disk in GB."
  default     = 30
}

variable "sap_nw_ers_boot_disk_type" {
  description = "Type of the NetWeaver ERS boot disk. Set to pd-standard (for PD HDD)."
  default     = "pd-ssd"
}

variable "sap_nw_ers_autodelete_boot_disk" {
  description = "Whether to auto-delete the boot disk when the instance is deleted."
}

variable "sap_nw_ers_usrsap_disk_size" {
  description = "Size of the NetWeaver ERS usrsap disk in GB."
}

variable "sap_nw_ers_swap_disk_size" {
  description = "Size of the NetWeaver ERS swap disk in GB."
}

variable "sap_nw_ers_usrsap_disk_type" {
  description = "Type of the NetWeaver ERS usrsap disk."
  default     = "pd-ssd"
}

variable "sap_nw_ers_swap_disk_type" {
  description = "Type of the NetWeaver ERS swap disk."
  default     = "pd-ssd"
}

variable "sap_nw_ers_service_account_email" {
  description = "Email address of the service account to attach to the NetWeaver ERS instance."
}

variable "sap_nw_ers_network_tags" {
  description = "List of network tags for the NetWeaver ERS instance."
  type        = list(string)
  default     = []
}

variable "sap_nw_ers_pd_kms_key" {
  description = "KMS key for encrypting persistent disks. Uses Google-managed key if not provided."
}

variable "sap_nw_ers_labels" {
  description = "Labels to apply to the NetWeaver ERS instance."
  default     = {}
}

variable "sap_nw_ers_create_instance_group" {
  description = "Whether to create the NetWeaver ERS instance group."
  type        = bool
  default     = true
}

variable "sap_nw_ers_instance_group_name" {
  description = "Name of the primary NetWeaver ERS instance group."
}

variable "sap_nw_ers_alias_ip" {
  description = "Alias IP address for the NetWeaver ERS instance (optional)."
  default     = ""
}

variable "sap_nw_ers_named_ports" {
  type = list(object({
    name = string
    port = number
  }))
  description = "List of named ports for the ERS instance."
  default     = []
}


##PAS Variables
variable "sap_nw_pas_instance_name" {
  description = "Name of the NetWeaver PAS instance. Changing this will create a new instance."
}

variable "sap_nw_pas_instance_ip" {
  description = "Static IP address for the NetWeaver PAS instance. Changing this will create a new instance."
}

variable "sap_nw_pas_instance_type" {
  description = "GCP instance/machine type for the NetWeaver PAS instance."
  default     = "n1-highmem-32"
}

variable "sap_nw_pas_boot_disk_size" {
  description = "Size of the NetWeaver PAS boot disk in GB."
  default     = 30
}

variable "sap_nw_pas_boot_disk_type" {
  description = "Type of the NetWeaver PAS boot disk. Set to pd-standard (for PD HDD)."
  default     = "pd-ssd"
}

variable "sap_nw_pas_autodelete_boot_disk" {
  description = "Whether to auto-delete the boot disk when the instance is deleted."
}

variable "sap_nw_pas_usrsap_disk_size" {
  description = "Size of the NetWeaver PAS usrsap disk in GB."
}

variable "sap_nw_pas_swap_disk_size" {
  description = "Size of the NetWeaver PAS swap disk in GB."
}

variable "sap_nw_pas_usrsap_disk_type" {
  description = "Type of the NetWeaver PAS usrsap disk."
  default     = "pd-ssd"
}

variable "sap_nw_pas_swap_disk_type" {
  description = "Type of the NetWeaver PAS swap disk."
  default     = "pd-ssd"
}

variable "sap_nw_pas_service_account_email" {
  description = "Email address of the service account to attach to the NetWeaver PAS instance."
}

variable "sap_nw_pas_network_tags" {
  description = "List of network tags for the NetWeaver PAS instance."
  type        = list(string)
  default     = []
}

variable "sap_nw_pas_pd_kms_key" {
  description = "KMS key for encrypting persistent disks. Uses Google-managed key if not provided."
}

variable "sap_nw_pas_labels" {
  description = "Labels to apply to the NetWeaver PAS instance."
  default     = {}
}

variable "sap_nw_pas_create_instance_group" {
  description = "Whether to create the NetWeaver PAS instance group."
  type        = bool
  default     = false
}

variable "sap_nw_pas_instance_group_name" {
  description = "Name of the primary NetWeaver PAS instance group."
  default     = ""
}

variable "sap_nw_pas_alias_ip" {
  description = "Alias IP address for the NetWeaver PAS instance (optional)."
  default     = ""
}


## ASCS ILB Variables
variable "network_project" {
  description = "Name or self-link of the network's project. Must reside in the instance's region."
}

variable "sap_nw_ascs_ilb_name" {
  description = "Name of the ASCS internal load balancer."
}

variable "sap_nw_ascs_health_check_port" {
  description = "Port for the ASCS health check."
}

variable "sap_nw_ascs_health_check_port_name" {
  description = "Port name for the ASCS health check."
}

variable "sap_nw_ascs_ilb_ip_address" {
  description = "IP address for the ASCS internal load balancer."
}

variable "sap_nw_ascs_health_check_name" {
  description = "Name of the ASCS health check."
}

variable "sap_nw_ascs_backend_service_name" {
  description = "Name of the ASCS backend service."
}

## ERS ILB Variables
variable "sap_nw_ers_ilb_name" {
  description = "Name of the ERS internal load balancer."
}

variable "sap_nw_ers_health_check_port" {
  description = "Port for the ERS health check."
}

variable "sap_nw_ers_health_check_port_name" {
  description = "Port name for the ERS health check."
}

variable "sap_nw_ers_ilb_ip_address" {
  description = "IP address for the ERS internal load balancer."
}

variable "sap_nw_ers_health_check_name" {
  description = "Name of the ERS health check."
}

variable "sap_nw_ers_backend_service_name" {
  description = "Name of the ERS backend service."
}

variable "nw_script_path" {
  description = "Path to the NetWeaver startup script (optional)."
  default     = ""
}

variable "hana_script_path" {
  description = "Path to the HANA startup script (optional)."
  default     = ""
}