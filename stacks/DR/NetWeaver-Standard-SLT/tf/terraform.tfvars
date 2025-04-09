project_id         = "sap-iac-test"
subnetwork         = "db-central"
subnetwork_project = "sap-iac-test"
# source_image_name    = "rhel-8-8-sap-v20241210"
# source_image_project = "rhel-sap-cloud"
gce_ssh_user         = "mahekar"
gce_ssh_pub_key_file = "~/.ssh/id_rsa.pub"


sap_nw_dr_zone                  = "us-central1-f"
sap_nw_dr_instance_name         = "uscdrsltapp"
sap_nw_dr_instance_ip           = "10.5.0.14"
sap_nw_dr_instance_type         = "n2-standard-4"
sap_nw_dr_use_public_ip         = false
sap_nw_dr_boot_disk_size        = 20
sap_nw_dr_boot_disk_type        = "pd-ssd"
sap_nw_dr_autodelete_boot_disk  = true
sap_nw_dr_usrsap_disk_size      = 20
sap_nw_dr_swap_disk_size        = 2
sap_nw_dr_usrsap_disk_type      = "pd-ssd"
sap_nw_dr_swap_disk_type        = "pd-ssd"
sap_nw_dr_service_account_email = "811811474621-compute@developer.gserviceaccount.com"
sap_nw_dr_network_tags          = ["sap-allow-all"]
sap_nw_dr_pd_kms_key            = "projects/sap-iac-test/locations/global/keyRings/paypal-ring/cryptoKeys/paypal-key"
sap_nw_dr_labels = {
  app = "nw"
}
sap_nw_dr_alias_ip           = ["10.5.0.16"]
sap_nw_primary_instance_name = "uscsltapp01"
sap_nw_primary_zone          = "us-central1-a"