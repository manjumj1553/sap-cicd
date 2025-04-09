/**
 * Copyright 2019 Google LLC
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
  type        = string
  description = "GCP project ID for resource deployment."
  default     = null
}

variable "network" {
  description = "Name or self-link of the network for instance deployment. Must reside in the instance's region."
  default     = ""
}

variable "subnetwork" {
  description = "Name or self-link of the subnetwork for instance deployment. Must reside in the instance's region."
  default     = ""
}

variable "subnetwork_project" {
  description = "Name or self-link of the subnetwork's project. Must reside in the instance's region."
  default     = ""
}

###########
# metadata
###########
variable "metadata" {
  type        = map(string)
  description = "Metadata, provided as a map"
  default     = {}
}

variable "source_image" {
  description = "Source disk image. If neither source_image nor source_image_family is specified, defaults to the latest public CentOS image."
  default     = ""
}

variable "source_image_project" {
  description = "Project where the source image comes from. The default project contains images that support Shielded VMs if desired"
  default     = "gce-uefi-images"
}

variable "region" {
  description = "The GCP region where the unmanaged instance group resides."
  type        = string
}

variable "zone" {
  description = "The GCP zone where the unmanaged instance resides."
  type        = string
}

variable "hostname" {
  description = "Hostname of instances"
  default     = ""
}

variable "static_ips" {
  type        = list(string)
  description = "List of static IPs for VM instances"
  default     = []
}

variable "access_config" {
  description = "Access configurations, i.e. IPs via which the VM instance can be accessed via the Internet."
  type = list(object({
    nat_ip       = string
    network_tier = string
  }))
  default = []
}

variable "machine_type" {
  description = "GCP instance/machine type for the instance."
  default     = "n1-standard-1"
}

variable "auto_append_hostname" {
  description = "Whether or not to a append number to the hostname. This will always be true if the number of instances is greater than 1."
  type        = bool
  default     = true
}

variable "num_instances" {
  description = "Number of instances to create. This value is ignored if static_ips is provided."
  default     = "1"
}

variable "alias_ip_range" {
  default     = null
  description = "Whether to enable the Shielded VM configuration on the instance. Note that the instance image must support Shielded VMs. See https://cloud.google.com/compute/docs/images"
}

variable "disk_size" {
  description = "Boot disk size in GB"
  default     = "100"
}

variable "disk_type" {
  description = "Boot disk type, can be either pd-ssd, local-ssd, or pd-standard"
  default     = "pd-standard"
}

variable "auto_delete" {
  description = "Whether or not the boot disk should be auto-deleted"
  default     = "true"
}

##################
# service_account
##################

variable "service_account" {
  type = object({
    email  = string
    scopes = set(string)
  })
  description = "Service account to attach to the instance. See https://www.terraform.io/docs/providers/google/r/compute_instance_template.html#service_account."
}

variable "tags" {
  type        = list(string)
  description = "Network tags, provided as a list"
  default     = []
}

variable "pd_kms_key" {
  description = "Customer managed encryption key to use in persistent disks. If none provided, a Google managed key will be used.."
}

variable "labels" {
  type        = map(string)
  description = "Labels, provided as a map"
  default     = {}
}

variable "create_instance_group" {
  description = "If set to true, it will create instance group"
  type        = bool
  default     = true
}

variable "instance_group_name" {
  description = "instance group name"
}

variable "named_ports" {
  description = "Named name and named port"
  type = list(object({
    name = string
    port = number
  }))
  default = []
}

variable "device_boot" {
  description = "Device name"
  default     = "boot"
}

variable "can_ip_forward" {
  description = "Enable IP forwarding, for NAT instances for example"
  default     = "false"
}