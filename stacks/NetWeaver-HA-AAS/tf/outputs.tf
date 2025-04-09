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

output "nw_aas_instance_ip_a" {
  value = [for instance_ip in module.netweaver_aas.instance_ips_a : instance_ip]
}

output "nw_aas_instance_ip_b" {
  value = [for instance_ip in module.netweaver_aas.instance_ips_b : instance_ip]
}

output "inventory" {
  value = local.inventory
}

output "subnet_cidr_nw_a" {
  value = data.google_compute_subnetwork.subnetwork_nw_a.ip_cidr_range
}

output "subnet_cidr_nw_b" {
  value = data.google_compute_subnetwork.subnetwork_nw_b.ip_cidr_range
}

output "aas_alias_ip_a" {
  value = [
    for instance in data.google_compute_instance.aas_alias_ip_a :
    trimsuffix(instance.network_interface[0].alias_ip_range[0].ip_cidr_range, "/32")
  ]
}

output "aas_alias_ip_b" {
  value = [
    for instance in data.google_compute_instance.aas_alias_ip_b :
    trimsuffix(instance.network_interface[0].alias_ip_range[0].ip_cidr_range, "/32")
  ]
}