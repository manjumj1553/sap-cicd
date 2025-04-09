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

output "primary_hana_instance_name" {
  description = "Name of primary HANA instance."
  value       = var.sap_hana_primary_instance_name
}

output "secondary_hana_instance_name" {
  description = "Name of Secondary HANA instance."
  value       = var.sap_hana_secondary_instance_name
}

output "hana_data_size" {
  value = module.hana_ha_primary.hana_data_size
}

output "hana_shared_size" {
  value = module.hana_ha_primary.hana_shared_size
}

output "hana_log_size" {
  value = module.hana_ha_primary.hana_log_size
}

output "hana_usr_size" {
  value = module.hana_ha_primary.hana_usr_size
}

output "hana_swap_size" {
  value = module.hana_ha_primary.hana_swap_size
}

output "hana_attached_disks_data" {
  value = module.hana_ha_primary.instance_attached_disks_data
}

output "inventory" {
  value = concat(module.hana_ha_primary.inventory, module.hana_ha_secondary.inventory)
}

output "primary_zone" {
  description = "Compute Engine instance deployment zone"
  value       = var.sap_hana_primary_zone
}

output "secondary_zone" {
  description = "Compute Engine instance deployment zone"
  value       = var.sap_hana_secondary_zone
}

output "health_check_port" {
  value = local.health_check["port"]
}

output "primary_source_image_name" {
  value = module.hana_ha_primary.sap_image_name
}

output "secondary_source_image_name" {
  value = module.hana_ha_secondary.sap_image_name
}