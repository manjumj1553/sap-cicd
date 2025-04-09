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

output "instance_name_a" {
  description = "Name of Netweaver instance in zone_a"
  value       = [for instance in google_compute_instance.gcp_nw_a : instance.name]
}

output "instance_name_b" {
  description = "Name of Netweaver instance in zone_b"
  value       = [for instance in google_compute_instance.gcp_nw_b : instance.name]
}

output "zone_a" {
  description = "Compute Engine instance deployment zone_a"
  value       = [for instance in google_compute_instance.gcp_nw_a : instance.zone]
}

output "zone_b" {
  description = "Compute Engine instance deployment zone_b"
  value       = [for instance in google_compute_instance.gcp_nw_b : instance.zone]
}

output "instance_internal_ip_a" {
  description = "internal IP of instance in zone_a"
  value       = [for instance in google_compute_instance.gcp_nw_a : instance.network_interface.0.network_ip]
}

output "instance_internal_ip_b" {
  description = "internal IP of instance in zone_b"
  value       = [for instance in google_compute_instance.gcp_nw_b : instance.network_interface.0.network_ip]
}

output "instance_attached_disks_usrsap_a" {
  value = [for disk in google_compute_disk.gcp_nw_pd_0_a : disk.name]
}

output "instance_attached_disks_usrsap_b" {
  value = [for disk in google_compute_disk.gcp_nw_pd_0_b : disk.name]
}

output "instance_attached_disks_swap_a" {
  value = [for disk in google_compute_disk.gcp_nw_pd_1_a : disk.name]
}

output "instance_attached_disks_swap_b" {
  value = [for disk in google_compute_disk.gcp_nw_pd_1_b : disk.name]
}

output "device_name_usr_sap_a" {
  value = [for disk in google_compute_attached_disk.gcp_nw_attached_pd_0_a : disk.device_name]
}

output "device_name_usr_sap_b" {
  value = [for disk in google_compute_attached_disk.gcp_nw_attached_pd_0_b : disk.device_name]
}

output "device_name_swap_a" {
  value = [for disk in google_compute_attached_disk.gcp_nw_attached_pd_1_a : disk.device_name]
}

output "device_name_swap_b" {
  value = [for disk in google_compute_attached_disk.gcp_nw_attached_pd_1_b : disk.device_name]
}