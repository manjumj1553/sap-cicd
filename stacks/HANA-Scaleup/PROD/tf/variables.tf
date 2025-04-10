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


##HANA Variables

variable "sap_zone" {
  description = "GCP zone for instance deployment."
  default     = "us-central1-a"
}

variable "sap_instance_name" {
  description = "Name of the HANA instance. Changing this will create a new instance."
}

variable "sap_instance_ip" {
  description = "Static IP address for the HANA instance. Changing this will create a new instance."
}

variable "sap_instance_type" {
  description = "GCP instance/machine type for the HANA instance."
  default     = "n1-highmem-32"
}

variable "sap_use_public_ip" {
  description = "Determines whether to assign a public IP address to the HANA instance."
  type        = bool
  default     = false
}

variable "sap_boot_disk_size" {
  description = "Size of the HANA boot disk in GB."
  default     = 30
}

variable "sap_boot_disk_type" {
  description = "Type of the HANA boot disk. Set to pd-standard (for PD HDD)."
  default     = "pd-ssd"
}

variable "sap_autodelete_boot_disk" {
  description = "Whether to auto-delete the boot disk when the instance is deleted."
}

variable "sap_data_disk_size" {
  description = "Size of the HANA data disk in GB."
}

variable "sap_log_disk_size" {
  description = "Size of the HANA log disk in GB."
}

variable "sap_shared_disk_size" {
  description = "Size of the HANA shared disk in GB."
}

variable "sap_usrsap_disk_size" {
  description = "Size of the HANA usrsap disk in GB."
}

variable "sap_swap_disk_size" {
  description = "Size of the HANA swap disk in GB."
}

variable "sap_data_disk_type" {
  description = "Type of the HANA data disk."
  default     = "pd-ssd"
}

variable "sap_log_disk_type" {
  description = "Type of the HANA log disk."
  default     = "pd-ssd"
}

variable "sap_shared_disk_type" {
  description = "Type of the HANA shared disk."
  default     = "pd-ssd"
}

variable "sap_usrsap_disk_type" {
  description = "Type of the HANA usrsap disk."
  default     = "pd-ssd"
}

variable "sap_swap_disk_type" {
  description = "Type of the HANA swap disk."
  default     = "pd-ssd"
}

variable "sap_addon_disks" {
  description = "Additional disks for the HANA instance."
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

variable "sap_service_account_email" {
  description = "Email address of the service account to attach to the HANA instance."
}

variable "sap_network_tags" {
  description = "List of network tags for the HANA instance."
  type        = list(string)
  default     = []
}

variable "sap_pd_kms_key" {
  description = "KMS key for encrypting persistent disks. Uses Google-managed key if not provided."
}

variable "sap_labels" {
  description = "Labels to apply to the HANA instance."
  default     = {}
}

variable "nw_script_path" {
  description = "Path to the NetWeaver startup script (optional)."
  default     = ""
}

variable "hana_script_path" {
  description = "Path to the HANA startup script (optional)."
  default     = ""
}


# variable "hana_swap_size" {
#   description = "HANA swap disk size in GB"
# }