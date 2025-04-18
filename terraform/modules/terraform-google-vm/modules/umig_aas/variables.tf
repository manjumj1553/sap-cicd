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
  description = "The GCP project ID"
  default     = null
}

variable "network" {
  description = "Network to deploy to. Only one of network or subnetwork should be specified."
  default     = ""
}

variable "region" {
  description = "The GCP region where the unmanaged instance group resides."
  type        = string
}

variable "zone" {
  description = "The GCP zone where the unmanaged instance resides."
  type        = string
}

variable "subnetwork" {
  description = "Subnet to deploy to. Only one of network or subnetwork should be specified."
  default     = ""
}

variable "subnetwork_project" {
  description = "The project that subnetwork belongs to"
  default     = ""
}

variable "hostname" {
  description = "Hostname of instances"
  default     = ""
}

variable "auto_append_hostname" {
  description = "Whether or not to a append number to the hostname. This will always be true if the number of instances is greater than 1."
  type        = bool
  default     = true
}

variable "static_ips" {
  type        = list(string)
  description = "List of static IPs for VM instances"
  default     = []
}

variable "num_instances" {
  description = "Number of instances to create. This value is ignored if static_ips is provided."
  default     = "1"
}

variable "named_ports" {
  description = "Named name and named port"
  type = list(object({
    name = string
    port = number
  }))
  default = []
}

variable "instance_template" {
  description = "Instance template self_link used to create compute instances"
}

variable "access_config" {
  description = "Access configurations, i.e. IPs via which the VM instance can be accessed via the Internet."
  type = list(object({
    nat_ip       = string
    network_tier = string
  }))
  default = []
}

variable "alias_ip_range" {
  default     = null
  description = "Whether to enable the Shielded VM configuration on the instance. Note that the instance image must support Shielded VMs. See https://cloud.google.com/compute/docs/images"
}

variable "create_instance_group" {
  description = "If set to true, it will create instance group"
  type        = bool
  default     = true
}

variable "instance_group_name" {
  description = "instance group name"
}