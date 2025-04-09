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

output "instance_ips_a" {
  value = google_compute_address.internal_ip_a.*.address
}

output "instance_ips_b" {
  value = google_compute_address.internal_ip_b.*.address
}

output "alias_ips_a" {
  value = local.aas_alias_ip_range_a
}