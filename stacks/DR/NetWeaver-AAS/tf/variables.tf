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

variable "sap_nw_dr_aas_zone" {
  description = "GCP DR zone for instance deployment."
  default     = "us-central1-b"
}

##AAS Variables
variable "sap_nw_dr_aas_instance_name" {
  description = "Name of the NetWeaver AAS instance in DR. Changing this will create a new instance."
}

variable "sap_nw_dr_aas_instance_ip" {
  description = "Static IP address for the NetWeaver AAS instance in DR. Changing this will create a new instance."
}

variable "sap_nw_dr_aas_instance_type" {
  description = "GCP instance/machine type for the NetWeaver AAS instance in DR."
  default     = "n1-highmem-32"
}

variable "sap_nw_dr_aas_boot_disk_size" {
  description = "Size of the DR NetWeaver AAS boot disk in GB."
  default     = 30
}

variable "sap_nw_dr_aas_boot_disk_type" {
  description = "Type of the DR NetWeaver AAS boot disk. Set to pd-standard (for PD HDD)."
  default     = "pd-ssd"
}

variable "sap_nw_dr_aas_autodelete_boot_disk" {
  description = "Whether to auto-delete the boot disk when the instance is deleted."
}

variable "sap_nw_dr_aas_usrsap_disk_size" {
  description = "Size of the DR NetWeaver AAS usrsap disk in GB."
}

variable "sap_nw_dr_aas_swap_disk_size" {
  description = "Size of the DR NetWeaver AAS swap disk in GB."
}

variable "sap_nw_dr_aas_usrsap_disk_type" {
  description = "Type of the DR NetWeaver AAS usrsap disk."
  default     = "pd-ssd"
}

variable "sap_nw_dr_aas_swap_disk_type" {
  description = "Type of the DR NetWeaver AAS swap disk."
  default     = "pd-ssd"
}

variable "sap_nw_dr_aas_service_account_email" {
  description = "Email address of the service account to attach to the DR NetWeaver AAS instance."
}

variable "sap_nw_dr_aas_network_tags" {
  description = "List of network tags for the DR NetWeaver AAS instance."
  type        = list(string)
  default     = []
}

variable "sap_nw_dr_aas_pd_kms_key" {
  description = "KMS key for encrypting persistent disks. Uses Google-managed key if not provided."
}

variable "sap_nw_dr_aas_labels" {
  description = "Labels to apply to the DR NetWeaver AAS instance."
  default     = {}
}

variable "sap_nw_dr_aas_create_instance_group" {
  description = "Whether to create the DR NetWeaver AAS instance group."
  type        = bool
  default     = false
}

variable "sap_nw_dr_aas_instance_group_name" {
  description = "Name of the primary DR NetWeaver AAS instance group."
  default     = ""
}

variable "sap_nw_dr_aas_alias_ip" {
  description = "Alias IP address for the DR NetWeaver AAS instance (optional)."
  default     = ""
}

variable "sap_nw_dr_aas_instance_map" {
  description = "List of AAS instance device snapshot map."
}

variable "nw_script_path" {
  description = "Path to the NetWeaver startup script (optional)."
  default     = ""
}

variable "hana_script_path" {
  description = "Path to the HANA startup script (optional)."
  default     = ""
}