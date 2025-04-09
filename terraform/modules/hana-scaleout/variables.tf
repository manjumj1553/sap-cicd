variable "project_id" {
  description = "GCP project ID for resource deployment."
}

variable "subnetwork" {
  description = "Name or self-link of the subnetwork for instance deployment. Must reside in the instance's region."
}

variable "subnetwork_project" {
  description = "Name or self-link of the subnetwork's project. Must reside in the instance's region."
}

variable "source_image_name" {
  description = "Name of the GCE source image."
}

variable "source_image_project" {
  description = "GCP project containing the source image."
}

variable "gce_ssh_user" {
  description = "Username for SSH access to the GCE instance."
}

variable "gce_ssh_pub_key_file" {
  description = "Path to the SSH public key file for authentication."
  default     = "~/.ssh/id_rsa.pub"
}

variable "zone" {
  description = "GCP zone for instance deployment."
}

variable "master_instance_name" {
  description = "Name of the instance. Changing this will create a new instance."
}

variable "worker_instance_names" {
  description = "Name of the instance. Changing this will create a new instance."
}

variable "master_instance_ip" {
  description = "Static IP address for the instance. Changing this will create a new instance."
}

variable "worker_instance_ips" {
  description = "Static IP address for the instance. Changing this will create a new instance."
}

variable "instance_type" {
  description = "GCP instance/machine type for the instance."
}

variable "use_public_ip" {
  description = "Determines whether to assign a public IP address to the instance."
  type        = bool
}

variable "boot_disk_size" {
  description = "Size of the boot disk in GB."
}

variable "boot_disk_type" {
  description = "Type of the boot disk."
}

variable "autodelete_disk" {
  description = "Whether to auto-delete the boot disk when the instance is deleted."
}

variable "data_disk_size" {
  description = "Size of the data disk in GB."
}

variable "log_disk_size" {
  description = "Size of the log disk in GB."
}

variable "usrsap_disk_size" {
  description = "Size of the usrsap disk in GB."
}

variable "swap_disk_size" {
  description = "Size of the swap disk in GB."
}

variable "data_disk_type" {
  description = "Type of the data disk."
}

variable "log_disk_type" {
  description = "Type of the log disk."
}

variable "usrsap_disk_type" {
  description = "Type of the usrsap disk."
}

variable "swap_disk_type" {
  description = "Type of the swap disk."
}

variable "hana_addon_disks" {
  description = "Additional disks for the instance."
  type = object({
    name         = list(string)
    disk_size_gb = list(number)
    disk_type    = list(string)
  })
}

variable "service_account_email" {
  description = "Email address of the service account to attach to the instance."
}

variable "network_tags" {
  description = "List of network tags for the instance."
}

variable "pd_kms_key" {
  description = "KMS key for encrypting persistent disks. Uses Google-managed key if not provided."
}

variable "labels" {
  description = "Labels to apply to the instance."
}

variable "target_size" {
  description = "Desired number of running instances zone. Required unless attached to an autoscaler."
  default     = 1
}

variable "device_boot" {
  description = "Name of the boot disk device."
  default     = "boot"
}

variable "device_log" {
  description = "Name of the log disk device."
  default     = "log"
}

variable "device_data" {
  description = "Name of the data disk device."
  default     = "data"
}

variable "device_usrsap" {
  description = "Name of the usrsap disk device."
  default     = "usrsap"
}

variable "device_swap" {
  description = "Name of the swap disk device."
  default     = "swap"
}