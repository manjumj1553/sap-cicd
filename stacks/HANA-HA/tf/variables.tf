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
}

variable "sap_hana_primary_zone" {
  description = "The zone that the primary instance should be created in."
  default     = "us-west4-a"
}
variable "sap_hana_secondary_zone" {
  description = "The zone that the secondary instance should be created in."
  default     = "us-west4-b"
}

variable "sap_hana_primary_instance_name" {
  description = "A unique name for the Primary HANA instance. Changing this forces a new resource to be created."
}

variable "sap_hana_primary_instance_ip" {
  description = "A unique ip for the Primary HANA instance. Changing this forces a new resource to be created."
}

variable "sap_hana_secondary_instance_name" {
  description = "A unique name for the secondary HANA instance. Changing this forces a new resource to be created."
}

variable "sap_hana_secondary_instance_ip" {
  description = "A unique ip for the secondary HANA instance. Changing this forces a new resource to be created."
}

variable "sap_hana_instance_type" {
  description = "The GCE instance/machine type for HANA."
  default     = "n1-highmem-32"
}

variable "source_image_name" {
  description = "GCE source_image name."
}

variable "source_image_project" {
  description = "Project name containing the source image."
}

variable "sap_hana_autodelete_boot_disk" {
  description = "Whether the disk will be auto-deleted when the instance is deleted."
}

variable "sap_hana_boot_disk_size" {
  description = "Root disk size in GB for HANA."
  default     = 30
}

variable "sap_hana_boot_disk_type" {
  description = "The GCE boot disk type for HANA. Set to pd-standard (for PD HDD)."
  default     = "pd-balanced"
}

variable "sap_hana_pd_kms_key" {
  description = "Customer managed encryption key to use in persistent disks. If none provided, a Google managed key will be used.."
}

variable "sap_hana_additional_disk_type" {
  description = "The GCE additional disk type for HANA. Set to pd-ssd (for PD SSD)."
}

variable "sap_hana_service_account_email" {
  description = "Email of service account to attach to the HANA instance."
}

variable "subnetwork_hana" {
  description = "The name or self_link of the hana subnetwork where the isntance will be deployed. The subnetwork must exist in the same region this instance will be created in."
}

variable "subnetwork_project" {
  description = "The name or self_link of the subnetwork project where the isntance will be deployed. The subnetwork must exist in the same region this instance will be created in."
  default     = ""
}

variable "sap_hana_network_tags" {
  type        = list(string)
  description = "List of network tags to attach to the instance."
  default     = []
}

variable "gce_ssh_user" {
  description = "GCE ssh user"
}

variable "gce_ssh_pub_key_file" {
  description = "GCE ssh user pub key file name"
  default     = "~/.ssh/id_rsa.pub"
}

variable "sap_hana_data_size" {
  description = "HANA data disk size in GB"
}

variable "sap_hana_log_size" {
  description = "HANA log disk size in GB"
}

variable "sap_hana_usr_size" {
  description = "HANA usr disk size in GB"
}

variable "sap_hana_shared_size" {
  description = "HANA shared disk size in GB"
}

variable "sap_hana_swap_size" {
  description = "HANA swap disk size in GB"
}

variable "primary_instance_group_name" {
  description = "primary instance group name"
}

variable "secondary_instance_group_name" {
  description = "secondary instance group name"
}

variable "hana_health_check_name" {
  description = "hana health check name"
}

variable "hana_ilb_name" {
  description = "hana ilb name"
}

variable "hana_ilb_ip_address" {
  description = "hana ilb ip address"
}

variable "backend_service_name" {
  description = "backend service name"
}

variable "hana_script_path" {
  description = "hana startup script path"
}

variable "nw_script_path" {
  description = "netweaver startup script path"
}

variable "sap_hana_primary_labels" {
  description = "List of labels to attach to the HANA instance."
  default     = {}
}

variable "sap_hana_secondary_labels" {
  description = "List of labels to attach to the HANA instance."
  default     = {}
}

variable "sap_hana_install_files_bucket" {
  description = "SAP HANA install files GCE bucket name"
}

variable "hana_health_check_port" {
  description = "hana health check port"
}

variable "sap_hana_usr_disk_type" {
  description = "Type of usrsap disk for HANA."
}

variable "sap_hana_swap_disk_type" {
  description = "Type of swap disk for HANA"
}

variable "sap_hana_shared_disk_type" {
  description = "Type of shared disk for HANA."
}

variable "sap_hana_data_disk_type" {
  description = "Type of data disk for HANA."
}

variable "sap_hana_log_disk_type" {
  description = "Type of log disk for HANA."
}

variable "sap_hana_addon_disks" {
  description = "List of additional disk for HANA instance."
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