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

output "umig_self_link" {
  value = var.create_instance_group ? join("", module.umig.self_links) : null
}

output "instance_names" {
  value = [for link in module.umig.instances_self_links : split("/", link)[10]]
}

output "instance_ips" {
  value = google_compute_address.internal_ip.*.address
}
