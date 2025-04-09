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
  pas_inventory = [
    {
      host   = module.netweaver_pas.instance_ips[0],
      groups = ["nw"],
      vars = {
        sap_is_pas = true,
      }
    }
  ]
  inventory          = local.pas_inventory
  region             = join("-", slice(split("-", var.sap_nw_dr_pas_zone), 0, 2))
  subnetwork_project = var.subnetwork_project == "" ? var.project_id : var.subnetwork_project
  network_parts_nw   = split("/", data.google_compute_subnetwork.subnetwork.network)
  network_nw         = element(local.network_parts_nw, length(local.network_parts_nw) - 1)
  num_as_instances   = length(module.netweaver_pas.instance_ips)
}
