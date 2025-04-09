project_id           = ""
zone                 = ""
gce_ssh_user         = ""
gce_ssh_pub_key_file = ""
subnetwork_project   = ""
source_image_name    = ""
source_image_project = ""

sap_hana_instance_name         = ""
sap_hana_instance_ip           = ""
sap_hana_instance_type         = ""
sap_hana_service_account_email = ""
subnetwork_hana                = ""
sap_hana_boot_disk_size        = 0
sap_hana_boot_disk_type        = ""
sap_hana_additional_disk_type  = ""
sap_hana_autodelete_boot_disk  = 0
sap_hana_network_tags          = [""]
sap_hana_pd_kms_key            = ""
sap_hana_create_backup_volume  = ""
sap_hana_install_files_bucket  = ""
hana_script_path               = ""
sap_hana_log_size              = ""
sap_hana_data_size             = ""
sap_hana_shared_size           = ""
sap_hana_usr_size              = ""
sap_hana_swap_size             = ""
sap_hana_labels = {
  app = ""
}
sap_hana_addon_disks = {
  name         = []
  disk_size_gb = []
  disk_type    = []
}


subnetwork_nw                = ""
sap_nw_autodelete_boot_disk  = 0
sap_nw_use_public_ip         = ""
sap_nw_usrsap_disk_size      = 0
sap_nw_swap_disk_size        = 0
sap_nw_instance_name         = ""
sap_nw_instance_ip           = ""
sap_nw_instance_type         = ""
sap_nw_network_tags          = [""]
sap_nw_boot_disk_size        = 0
sap_nw_boot_disk_type        = ""
sap_nw_additional_disk_type  = ""
sap_nw_service_account_email = ""
nw_script_path               = ""
sap_nw_pd_kms_key            = ""
sap_nw_labels = {
  app = ""
}
