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
  default     = "albatross-duncanl-sandbox-2"
}

variable "zone" {
  description = "The zone that the instance should be created in."
  default     = "us-central1-a"
}

variable "instance_name" {
  description = "A unique name for the resource, required by GCE. Changing this forces a new resource to be created."
  default     = "sap-nw"
}

variable "instance_ip" {
  description = "A unique ip for the resource, required by GCE. Changing this forces a new resource to be created."
}

variable "instance_type" {
  description = "The GCE instance/machine type."
  default     = "n1-standard-8"
}

variable "source_image_name" {
  description = "GCE image name."
}

variable "source_image_project" {
  description = "Project name containing the linux image."
  default     = "suse-sap-cloud"
}

variable "autodelete_disk" {
  description = "Whether the disk will be auto-deleted when the instance is deleted."
  default     = "false"
}

variable "usrsap_disk_size" {
  description = "USR SAP size"
  default     = 0
}

variable "additional_disk_type" {
  description = "The GCE data disk type. May be set to pd-standard (for PD HDD) or pd-ssd."
}

variable "boot_disk_size" {
  description = "Root disk size in GB."
  default     = 30
}

variable "boot_disk_type" {
  description = "The GCE boot disk type. May be set to pd-standard (for PD HDD) or pd-ssd."
  default     = "pd-ssd"
}

variable "service_account_email" {
  description = "Email of service account to attach to the instance."
}

variable "subnetwork" {
  description = "The name or self_link of the subnetwork where the isntance will be deployed. The subnetwork must exist in the same region this instance will be created in."
  default     = "app2"
}

variable "subnetwork_project" {
  description = "subnetwork project"
  default     = "albatross-duncanl-sandbox-2"
}

variable "network_tags" {
  type        = list(any)
  description = "List of network tags to attach to the instance."
}

variable "use_public_ip" {
  description = "Determines whether a public IP address is added to your VM instance."
  type        = bool
}

variable "device_0" {
  description = "Device name"
  default     = "boot"
}

variable "device_1" {
  description = "Device name"
  default     = "usrsap"
}

variable "gce_ssh_user" {
  description = "GCE ssh user"
}

variable "gce_ssh_pub_key_file" {
  description = "GCE ssh user pub key file name"
}

variable "startup_script" {
  description = "nw startup script"
}

variable "pd_kms_key" {
  description = "Customer managed encryption key to use in persistent disks. If none provided, a Google managed key will be used.."
}

variable "labels" {
  description = "List of labels to attach to the instance."
}

variable "target_size" {
  description = "The target number of running instances for the unmanaged instance group. This value should always be explicitly set unless this resource is attached to an autoscaler, in which case it should never be set."
}

variable "instance_group_name" {
  description = "Instance group name"
}

variable "is_primary" {
  description = "Identifier for nw primary host"
}