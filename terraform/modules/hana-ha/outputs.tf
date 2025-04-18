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

output "project_id" {
  value = var.project_id
}

output "zone" {
  description = "Compute Engine instance deployment zone"
  value       = var.zone
}

output "instances_self_links" {
  value = module.sap_hana_umig.instances_self_links
}

output "address" {
  value = google_compute_address.gcp_sap_hana_intip.address
}

output "hana_data_size" {
  value = var.hana_data_size
}

output "hana_shared_size" {
  value = var.hana_shared_size
}

output "hana_log_size" {
  value = var.hana_log_size
}

output "hana_usr_size" {
  value = var.hana_usr_size
}

output "hana_swap_size" {
  value = var.hana_swap_size
}

output "sap_image_name" {
  value = var.source_image_name
}

output "instance_attached_disks_data" {
  value = google_compute_attached_disk.data.device_name
}

output "instance_group_link" {
  value = module.sap_hana_umig.self_links[0]
}

output "instance_ip" {
  value = google_compute_address.gcp_sap_hana_intip.address
}

output "inventory" {
  value = [
    {
      host   = google_compute_address.gcp_sap_hana_intip.address,
      groups = ["hana"],
      vars = {
        sap_hana_is_primary = var.is_primary,
      },
    },
  ]
}
