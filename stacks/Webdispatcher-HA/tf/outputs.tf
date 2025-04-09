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

output "inventory" {
  value = concat(module.gcp_netweaver_primary.inventory, module.gcp_netweaver_secondary.inventory)
}

output "nw_primary_instance_name" {
  description = "Name of Primary NetWeaver instance."
  value       = module.gcp_netweaver_primary.instance_name
}

output "nw_secondary_instance_name" {
  description = "Name of Secondary NetWeaver instance."
  value       = module.gcp_netweaver_secondary.instance_name
}

output "primary_zone" {
  description = "Compute Engine instance deployment zone"
  value       = var.sap_nw_primary_zone
}

output "secondary_zone" {
  description = "Compute Engine instance deployment zone"
  value       = var.sap_nw_secondary_zone
}

output "umig_a_self_links" {
  value = module.gcp_netweaver_primary.umig
}

output "umig_b_self_links" {
  value = module.gcp_netweaver_secondary.umig
}