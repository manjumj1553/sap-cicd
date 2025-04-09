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

output "instance_name" {
  description = "Name of Netweaver instance in zone"
  value       = [for instance in google_compute_instance.gcp_nw : instance.name]
}

output "zone" {
  description = "Compute Engine instance deployment zone"
  value       = [for instance in google_compute_instance.gcp_nw : instance.zone]
}

output "instance_internal_ip" {
  description = "internal IP of instance in zone"
  value       = [for instance in google_compute_instance.gcp_nw : instance.network_interface.0.network_ip]
}

output "instance_attached_disks_usrsap" {
  value = [for disk in google_compute_disk.gcp_sap_nw_usrsap : disk.name]
}

output "instance_attached_disks_swap" {
  value = [for disk in google_compute_disk.gcp_sap_nw_swap : disk.name]
}

output "device_name_usr_sap" {
  value = [for disk in google_compute_attached_disk.gcp_sap_nw_attached_usrsap : disk.device_name]
}

output "device_name_swap" {
  value = [for disk in google_compute_attached_disk.gcp_sap_nw_attached_swap : disk.device_name]
}