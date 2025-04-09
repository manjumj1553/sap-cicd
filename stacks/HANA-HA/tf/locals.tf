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

locals {

  inventory          = concat(module.hana_ha_primary.inventory, module.hana_ha_secondary.inventory)
  region             = join("-", slice(split("-", var.sap_hana_primary_zone), 0, 2))
  network_parts      = split("/", data.google_compute_subnetwork.subnetwork_hana.network)
  network            = element(local.network_parts, length(local.network_parts) - 1)
  subnetwork_project = var.subnetwork_project == "" ? var.project_id : var.subnetwork_project
  network_parts_hana = split("/", data.google_compute_subnetwork.subnetwork_hana.network)
  network_hana       = element(local.network_parts_hana, length(local.network_parts_hana) - 1)

  health_check = {
    type                = "tcp"
    check_interval_sec  = 10
    healthy_threshold   = 4
    timeout_sec         = 10
    unhealthy_threshold = 5
    response            = ""
    proxy_header        = "NONE"
    port                = var.hana_health_check_port
    port_name           = "hana-health-check-port"
    request             = ""
    request_path        = "/"
    host                = ""
  }

}

