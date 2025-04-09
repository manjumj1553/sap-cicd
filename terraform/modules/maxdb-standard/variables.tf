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

variable "zone" {
  description = "GCP zone for instance deployment."
}

variable "subnetwork" {
  description = "Name or self-link of the subnetwork for instance deployment. Must reside in the instance's region."
}

variable "subnetwork_project" {
  description = "Name or self-link of the subnetwork's project. Must reside in the instance's region."
}

variable "source_image_name" {
  description = "Name of the GCE source image."
}

variable "source_image_project" {
  description = "GCP project containing the source image."
}

variable "gce_ssh_user" {
  description = "Username for SSH access to the GCE instance."
}

variable "gce_ssh_pub_key_file" {
  description = "Path to the SSH public key file for authentication."
  default     = "~/.ssh/id_rsa.pub"
}

variable "instance_name" {
  description = "Name of the instance. Changing this will create a new instance."
}

variable "instance_ip" {
  description = "Static IP address for the instance. Changing this will create a new instance."
}

variable "instance_type" {
  description = "GCP instance/machine type for the instance."
}

variable "use_public_ip" {
  description = "Determines whether to assign a public IP address to the instance."
  type        = bool
}

variable "boot_disk_size" {
  description = "Size of the boot disk in GB."
}

variable "boot_disk_type" {
  description = "Type of the boot disk."
}

variable "autodelete_disk" {
  description = "Whether to auto-delete the boot disk when the instance is deleted."
}

variable "usrsap_disk_size" {
  description = "Size of the usrsap disk in GB."
}

variable "sapdb_disk_size" {
  description = "Size of the sapdb disk in GB."
}

variable "maxdbbackup_disk_size" {
  description = "Size of the maxdbbackup disk in GB."
}

variable "usrsap_disk_type" {
  description = "Type of the usrsap disk."
}

variable "sapdb_disk_type" {
  description = "Type of the sapdb disk."
}

variable "maxdbbackup_disk_type" {
  description = "Type of the maxdbbackup disk."
}

variable "service_account_email" {
  description = "Email address of the service account to attach to the instance."
}

variable "network_tags" {
  description = "List of network tags for the instance."
}

variable "pd_kms_key" {
  description = "KMS key for encrypting persistent disks. Uses Google-managed key if not provided."
}

variable "labels" {
  description = "Labels to apply to the instance."
}

variable "device_boot" {
  description = "Name of the boot disk device."
  default     = "boot"
}

variable "device_usrsap" {
  description = "Name of the usrsap disk device."
  default     = "usrsap"
}

variable "device_sapdb" {
  description = "Name of the sapdb disk device."
  default     = "sapdb"
}

variable "device_maxdbbackup" {
  description = "Name of the maxdbbackup disk device."
  default     = "maxdbbackup"
}