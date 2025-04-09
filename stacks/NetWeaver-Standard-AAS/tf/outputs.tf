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
  value = concat(
    [
      for ip in module.gcp_netweaver.instance_internal_ip_a : {
        host   = ip,
        groups = ["nw"],
        vars = {
          sap_is_aas = true,
        }
      }
    ],
    [
      for ip in module.gcp_netweaver.instance_internal_ip_b : {
        host   = ip,
        groups = ["nw"],
        vars = {
          sap_is_aas = true,
        }
      }
    ]
  )
}

output "nw_instance_name_a" {
  description = "Name of NetWeaver instance in zone_a."
  value       = module.gcp_netweaver.instance_name_a
}

output "nw_instance_name_b" {
  description = "Name of NetWeaver instance in zone_b."
  value       = module.gcp_netweaver.instance_name_b
}

output "zone_a" {
  description = "Compute Engine instance deployment zone"
  value       = var.zone_a
}

output "zone_b" {
  description = "Compute Engine instance deployment zone"
  value       = var.zone_b
}