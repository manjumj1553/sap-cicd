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

output "ascs_instance_ip" {
  value = length(module.netweaver_ascs.instance_ips) == 0 ? "" : module.netweaver_ascs.instance_ips[0]
}

output "ers_instance_ip" {
  value = length(module.netweaver_ers.instance_ips) == 0 ? "" : module.netweaver_ers.instance_ips[0]
}

output "pas_instance_ip" {
  value = length(module.netweaver_as.instance_ips) == 0 ? "" : module.netweaver_as.instance_ips[0]
}

output "ascs_instance_name" {
  value = length(module.netweaver_ascs.instance_names) == 0 ? "" : module.netweaver_ascs.instance_names[0]
}

output "pas_instance_name" {
  value = length(module.netweaver_as.instance_names) == 0 ? "" : module.netweaver_as.instance_names[0]
}

output "ers_instance_name" {
  value = length(module.netweaver_ers.instance_names) == 0 ? "" : module.netweaver_ers.instance_names[0]
}

output "ascs_ilb_ip" {
  value = module.ascs_ilb.ip_address
}

output "ers_ilb_ip" {
  value = module.ers_ilb.ip_address
}

output "pas_alias_ip" {
  value = trimsuffix(data.google_compute_instance.pas_alias_ip.network_interface.0.alias_ip_range.0.ip_cidr_range, "/32")
}

output "inventory" {
  value = local.inventory
}

output "subnet_cidr_nw" {
  value = data.google_compute_subnetwork.subnetwork_nw.ip_cidr_range
}

output "nw_usrsap_disk_size" {
  value = var.nw_usrsap_disk_size
}

output "nw_swap_disk_size" {
  value = var.nw_swap_disk_size
}

output "ascs_health_check_port" {
  value = var.ascs_health_check_port
}

output "ers_health_check_port" {
  value = var.ers_health_check_port
}
