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
  aas_inventory = concat(
    [
      for ip in module.netweaver_aas.instance_ips_a : {
        host   = ip,
        groups = ["nw"],
        vars = {
          sap_is_aas = true,
        }
      }
    ],
    [
      for ip in module.netweaver_aas.instance_ips_b : {
        host   = ip,
        groups = ["nw"],
        vars = {
          sap_is_aas = true,
        }
      }
    ]
  )
  inventory          = local.aas_inventory
  subnetwork_project = var.subnetwork_project == "" ? var.project_id : var.subnetwork_project
}
