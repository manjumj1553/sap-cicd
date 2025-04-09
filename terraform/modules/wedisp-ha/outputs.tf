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
  description = "Name of Netweaver instance"
  value       = module.sap_nw_umig.instances_self_links
}

output "umig" {
  description = "Name of umig selflinks"
  value       = module.sap_nw_umig.self_links
}

output "instance_attached_disks_usrsap" {
  value = google_compute_disk.gcp_nw_pd_0.name
}

output "device_name_usr_sap" {
  value = local.device_name_1
}

output "inventory" {
  value = [
    {
      host   = google_compute_address.gcp_sap_nw_intip.address,
      groups = ["nw"],
      vars = {
        sap_nw_is_primary = var.is_primary,
      },
    },
  ]
}