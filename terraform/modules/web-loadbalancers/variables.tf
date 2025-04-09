variable "project_id" {
  description = "The GCP project to use for integration tests"
}

variable "env" {
  description = "WEB deployment environment"
}

variable "glb_address_1" {
  description = "External reserved IP address to be used by GLB 1"
}

variable "zone_a" {
  description = "The GCP primary zone to create and test resources in"
  type        = string
}

variable "subnetwork" {
  description = "The name of the subnetwork create this instance in."
}

variable "subnetwork_project" {
  description = "The ID of the project in which the subnetwork belongs. If it is not provided, the provider project is used."
}

variable "web_port_name" {
  description = "WEB healthcheck port name"
}

variable "tf_state_bucket_instance_prefix" {
  description = "Terraform instance bucket prefix"
}

variable "tf_state_bucket" {
  description = "Terraform state bucket"
}

variable "webdisp_sid" {
  description = "WEB deployment environment sid"
}
