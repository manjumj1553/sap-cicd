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

variable "region" {
  description = "Region to deploy the resources. Should be in the same region as the zone."
  default     = "us-central1"
}

variable "zone_a" {
  description = "The zone_a that the instance should be created in."
  default     = "us-central1-a"
}

variable "zone_b" {
  description = "The zone_b that the instance should be created in."
  default     = "us-central1-b"
}

variable "sap_nw_aas_instance_name_a" {
  description = "A unique name for the NW instance in zone_a. Changing this forces a new resource to be created."
}

variable "sap_nw_aas_instance_name_b" {
  description = "A unique name for the NW instance in zone_b. Changing this forces a new resource to be created."
}

variable "sap_nw_aas_instance_ip_a" {
  description = "A unique ip for the netweaver instance in zone_a. Changing this forces a new resource to be created."
}

variable "sap_nw_aas_instance_ip_b" {
  description = "A unique ip for the netweaver instance in zone_b. Changing this forces a new resource to be created."
}

variable "sap_nw_instance_type" {
  description = "The GCE instance/machine type for NetWeaver."
  default     = "n1-highmem-32"
}

variable "source_image_name" {
  description = "GCE source_image name."
}

variable "source_image_project" {
  description = "Project name containing the source image."
  default     = "rhel-sap-cloud"
}

variable "sap_nw_autodelete_boot_disk" {
  description = "Whether the disk will be auto-deleted when the instance is deleted."
}

variable "sap_nw_boot_disk_size" {
  description = "Root disk size in GB for NetWeaver."
  default     = 30
}

variable "sap_nw_boot_disk_type" {
  description = "The GCE boot disk type for NetWeaver. Set to pd-standard (for PD HDD)."
  default     = "pd-ssd"
}

variable "sap_nw_usrsap_disk_type" {
  description = "The GCE usrsap disk type for NetWeaver. Set to pd-standard (for PD HDD)."
  default     = "pd-ssd"
}

variable "sap_nw_swap_disk_type" {
  description = "The GCE swap disk type for NetWeaver. Set to pd-standard (for PD HDD)."
  default     = "pd-ssd"
}

variable "sap_nw_usrsap_disk_size" {
  description = "Size of /usr/sap for NetWeaver."
  default     = 150
}

variable "sap_nw_swap_disk_size" {
  description = "Size of swap for NetWeaver."
  default     = 30
}

variable "sap_nw_service_account_email" {
  description = "Email of service account to attach to the NetWeaver instance."
}

variable "subnetwork_nw" {
  description = "The name or self_link of the nw subnetwork where the isntance will be deployed. The subnetwork must exist in the same region this instance will be created in."
  default     = "app2"
}


variable "subnetwork_project" {
  description = "The name or self_link of the subnetwork project where the isntance will be deployed. The subnetwork must exist in the same region this instance will be created in."
  default     = ""
}

variable "sap_nw_network_tags" {
  type        = list(string)
  description = "List of network tags to attach to the instance."
  default     = []
}

variable "sap_nw_use_public_ip" {
  description = "Determines whether a public IP address is added to your VM instance."
  type        = bool
  default     = false
}

variable "gce_ssh_user" {
  description = "GCE ssh user"
}

variable "gce_ssh_pub_key_file" {
  description = "GCE ssh user pub key file name"
  default     = "~/.ssh/id_rsa.pub"
}

variable "nw_script_path" {
  description = "netweaver startup script path"
}

variable "hana_script_path" {
  description = "hana startup script path"
}

variable "sap_nw_pd_kms_key" {
  description = "Customer managed encryption key to use in persistent disks. If none provided, a Google managed key will be used.."
}

variable "sap_nw_aas_labels" {
  description = "List of labels to attach to the NW instance."
  default     = {}
}