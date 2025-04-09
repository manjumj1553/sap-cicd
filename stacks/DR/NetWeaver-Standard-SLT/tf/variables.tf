variable "project_id" {
  description = "GCP project ID for resource deployment."
}

variable "subnetwork" {
  description = "Name or self-link of the subnetwork for instance deployment. Must reside in the instance's region."
  default     = "app2"
}

variable "subnetwork_project" {
  description = "Name or self-link of the subnetwork's project. Must reside in the instance's region."
}

variable "gce_ssh_user" {
  description = "Username for SSH access to the GCE instance."
}

variable "gce_ssh_pub_key_file" {
  description = "Path to the SSH public key file for authentication."
  default     = "~/.ssh/id_rsa.pub"
}

variable "sap_nw_dr_zone" {
  description = "GCP zone for instance deployment."
  default     = "us-central1-a"
}

## NetWeaver Variables
variable "sap_nw_dr_instance_name" {
  description = "Name of the NetWeaver instance. Changing this will create a new instance."
}

variable "sap_nw_dr_instance_ip" {
  description = "Static IP address for the NetWeaver instance. Changing this will create a new instance."
}

variable "sap_nw_dr_instance_type" {
  description = "GCP instance/machine type for the NetWeaver instance."
  default     = "n1-highmem-32"
}

variable "sap_nw_dr_use_public_ip" {
  description = "Determines whether to assign a public IP address to the NetWeaver instance."
  type        = bool
  default     = false
}

variable "sap_nw_dr_boot_disk_size" {
  description = "Size of the NetWeaver boot disk in GB."
  default     = 30
}

variable "sap_nw_dr_boot_disk_type" {
  description = "Type of the NetWeaver boot disk. Set to pd-standard (for PD HDD)."
  default     = "pd-ssd"
}

variable "sap_nw_dr_autodelete_boot_disk" {
  description = "Whether to auto-delete the boot disk when the instance is deleted."
}

variable "sap_nw_dr_usrsap_disk_size" {
  description = "Size of the NetWeaver usrsap disk in GB."
}

variable "sap_nw_dr_swap_disk_size" {
  description = "Size of the NetWeaver swap disk in GB."
}

variable "sap_nw_dr_usrsap_disk_type" {
  description = "Type of the NetWeaver usrsap disk."
}

variable "sap_nw_dr_swap_disk_type" {
  description = "Type of the NetWeaver swap disk."
}

variable "sap_nw_dr_service_account_email" {
  description = "Email address of the service account to attach to the NetWeaver instance."
}

variable "sap_nw_dr_network_tags" {
  description = "List of network tags for the NetWeaver instance."
  type        = list(string)
  default     = []
}

variable "sap_nw_dr_pd_kms_key" {
  description = "KMS key for encrypting persistent disks. Uses Google-managed key if not provided."
}

variable "sap_nw_dr_labels" {
  description = "Labels to apply to the NetWeaver instance."
  default     = {}
}

variable "sap_nw_dr_alias_ip" {
  description = "Netweaver instance alias ips."
  type        = list(string)
}

variable "sap_nw_instance_map" {
  description = "List of SLT instance device snapshot map."
}

variable "nw_script_path" {
  description = "netweaver startup script path"
  default     = ""
}

variable "hana_script_path" {
  description = "hana startup script path"
  default     = ""
}

variable "sap_nw_primary_instance_name" {
  description = "Name of the NetWeaver PAS instance. Changing this will create a new instance."
}

variable "sap_nw_primary_zone" {
  description = "GCP zone for instance deployment."
  default     = "us-central1-a"
}