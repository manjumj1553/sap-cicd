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


##HANA Primary Variables
variable "sap_hana_primary_zone" {
  description = "GCP primary zone for HANA instance deployment."
  default     = "us-central1-a"
}

variable "sap_hana_primary_instance_name" {
  description = "Name of the primary HANA instance. Changing this will create a new instance."
}

variable "sap_hana_primary_instance_ip" {
  description = "Static IP address for the primary HANA instance. Changing this will create a new instance."
}

variable "sap_hana_primary_instance_type" {
  description = "GCP instance/machine type for the primary HANA instance."
  default     = "n1-highmem-32"
}

variable "sap_hana_primary_boot_disk_size" {
  description = "Size of the primary HANA boot disk in GB."
  default     = 30
}

variable "sap_hana_primary_boot_disk_type" {
  description = "Type of the primary HANA boot disk. Set to pd-standard (for PD HDD)."
  default     = "pd-ssd"
}

variable "sap_hana_primary_autodelete_boot_disk" {
  description = "Whether to auto-delete the boot disk when the instance is deleted."
}

variable "sap_hana_primary_data_disk_size" {
  description = "Size of the primary HANA data disk in GB."
}

variable "sap_hana_primary_log_disk_size" {
  description = "Size of the primary HANA log disk in GB."
}

variable "sap_hana_primary_shared_disk_size" {
  description = "Size of the primary HANA shared disk in GB."
}

variable "sap_hana_primary_usrsap_disk_size" {
  description = "Size of the primary HANA usrsap disk in GB."
}

variable "sap_hana_primary_swap_disk_size" {
  description = "Size of the primary HANA swap disk in GB."
}

variable "sap_hana_primary_data_disk_type" {
  description = "Type of the primary HANA data disk."
  default     = "pd-ssd"
}

variable "sap_hana_primary_log_disk_type" {
  description = "Type of the primary HANA log disk."
  default     = "pd-ssd"
}

variable "sap_hana_primary_shared_disk_type" {
  description = "Type of the primary HANA shared disk."
  default     = "pd-ssd"
}

variable "sap_hana_primary_usrsap_disk_type" {
  description = "Type of the primary HANA usrsap disk."
  default     = "pd-ssd"
}

variable "sap_hana_primary_swap_disk_type" {
  description = "Type of the primary HANA swap disk."
  default     = "pd-ssd"
}

variable "sap_hana_primary_addon_disks" {
  description = "Additional disks for the primary HANA instance."
  type = object({
    name         = list(string)
    disk_size_gb = list(number)
    disk_type    = list(string)
  })
  default = {
    name         = []
    disk_size_gb = []
    disk_type    = []
  }
}

variable "sap_hana_primary_service_account_email" {
  description = "Email address of the service account to attach to the primary HANA instance."
}

variable "sap_hana_primary_network_tags" {
  description = "List of network tags for the primary HANA instance."
  type        = list(string)
  default     = []
}

variable "sap_hana_primary_pd_kms_key" {
  description = "KMS key for encrypting persistent disks. Uses Google-managed key if not provided."
}

variable "sap_hana_primary_labels" {
  description = "Labels to apply to the primary HANA instance."
  default     = {}
}

variable "sap_hana_primary_instance_group_name" {
  description = "Name of the primary HANA instance group."
}

variable "sap_hana_primary_named_ports" {
  type = list(object({
    name = string
    port = number
  }))
  description = "List of named ports for the primary HANA instances"
  default     = []
}


##HANA Secondary Variables
variable "sap_hana_secondary_zone" {
  description = "GCP secondary zone for HANA instance deployment."
  default     = "us-central1-a"
}

variable "sap_hana_secondary_instance_name" {
  description = "Name of the secondary HANA instance. Changing this will create a new instance."
}

variable "sap_hana_secondary_instance_ip" {
  description = "Static IP address for the secondary HANA instance. Changing this will create a new instance."
}

variable "sap_hana_secondary_instance_type" {
  description = "GCP instance/machine type for the secondary HANA instance."
  default     = "n1-highmem-32"
}

variable "sap_hana_secondary_boot_disk_size" {
  description = "Size of the secondary HANA boot disk in GB."
  default     = 30
}

variable "sap_hana_secondary_boot_disk_type" {
  description = "Type of the secondary HANA boot disk. Set to pd-standard (for PD HDD)."
  default     = "pd-ssd"
}

variable "sap_hana_secondary_autodelete_boot_disk" {
  description = "Whether to auto-delete the boot disk when the instance is deleted."
}

variable "sap_hana_secondary_data_disk_size" {
  description = "Size of the secondary HANA data disk in GB."
}

variable "sap_hana_secondary_log_disk_size" {
  description = "Size of the secondary HANA log disk in GB."
}

variable "sap_hana_secondary_shared_disk_size" {
  description = "Size of the secondary HANA shared disk in GB."
}

variable "sap_hana_secondary_usrsap_disk_size" {
  description = "Size of the secondary HANA usrsap disk in GB."
}

variable "sap_hana_secondary_swap_disk_size" {
  description = "Size of the secondary HANA swap disk in GB."
}

variable "sap_hana_secondary_data_disk_type" {
  description = "Type of the secondary HANA data disk."
  default     = "pd-ssd"
}

variable "sap_hana_secondary_log_disk_type" {
  description = "Type of the secondary HANA log disk."
  default     = "pd-ssd"
}

variable "sap_hana_secondary_shared_disk_type" {
  description = "Type of the secondary HANA shared disk."
  default     = "pd-ssd"
}

variable "sap_hana_secondary_usrsap_disk_type" {
  description = "Type of the secondary HANA usrsap disk."
  default     = "pd-ssd"
}

variable "sap_hana_secondary_swap_disk_type" {
  description = "Type of the secondary HANA swap disk."
  default     = "pd-ssd"
}

variable "sap_hana_secondary_addon_disks" {
  description = "Additional disks for the secondary HANA instance."
  type = object({
    name         = list(string)
    disk_size_gb = list(number)
    disk_type    = list(string)
  })
  default = {
    name         = []
    disk_size_gb = []
    disk_type    = []
  }
}

variable "sap_hana_secondary_service_account_email" {
  description = "Email address of the service account to attach to the secondary HANA instance."
}

variable "sap_hana_secondary_network_tags" {
  description = "List of network tags for the secondary HANA instance."
  type        = list(string)
  default     = []
}

variable "sap_hana_secondary_pd_kms_key" {
  description = "KMS key for encrypting persistent disks. Uses Google-managed key if not provided."
}

variable "sap_hana_secondary_labels" {
  description = "Labels to apply to the secondary HANA instance."
  default     = {}
}

variable "sap_hana_secondary_instance_group_name" {
  description = "Name of the secondary HANA instance group."
}

variable "sap_hana_secondary_named_ports" {
  type = list(object({
    name = string
    port = number
  }))
  description = "List of named ports for the secondary HANA instances"
  default     = []
}

## ILB Variables
variable "network_project" {
  description = "Name or self-link of the network's project. Must reside in the instance's region."
}

variable "sap_hana_ilb_name" {
  description = "Name of the HANA internal load balancer."
}

variable "sap_hana_health_check_port" {
  description = "Port for the HANA health check."
}

variable "sap_hana_health_check_port_name" {
  description = "Port name for the HANA health check."
}

variable "sap_hana_ilb_ip_address" {
  description = "IP address for the HANA internal load balancer."
}

variable "sap_hana_health_check_name" {
  description = "Name of the HANA health check."
}

variable "sap_hana_backend_service_name" {
  description = "Name of the backend service for HANA."
}

variable "nw_script_path" {
  description = "Path to the NetWeaver startup script (optional)."
  default     = ""
}

variable "hana_script_path" {
  description = "Path to the HANA startup script (optional)."
  default     = ""
}