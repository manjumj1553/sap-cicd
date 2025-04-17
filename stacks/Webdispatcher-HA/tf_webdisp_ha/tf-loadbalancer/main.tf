module "web_loadbalancer" {
  source                          = "../../../../terraform/modules/web-loadbalancers"
  project_id                      = var.project_id
  env                             = var.env
  glb_address_1                   = var.glb_address_1
  zone_a                          = var.zone_a
  subnetwork                      = var.subnetwork
  subnetwork_project              = var.subnetwork_project
  web_port_name                   = var.web_port_name
  tf_state_bucket_instance_prefix = var.tf_state_bucket_instance_prefix
  tf_state_bucket                 = var.tf_state_bucket
  webdisp_sid                     = var.webdisp_sid
}
