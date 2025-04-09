project_id           = "sap-iac-test"
subnetwork           = "db-central"
subnetwork_project   = "sap-iac-test"
source_image_name    = "rhel-8-8-sap-v20241210"
source_image_project = "rhel-sap-cloud"
gce_ssh_user         = "mahekar"
gce_ssh_pub_key_file = "~/.ssh/id_rsa.pub"


zone                         = "us-central1-a"
sap_nw_instance_name         = "uscsltapp01"
sap_nw_instance_ip           = "10.5.0.44"
sap_nw_instance_type         = "n1-standard-4"
sap_nw_use_public_ip         = false
sap_nw_boot_disk_size        = 50
sap_nw_boot_disk_type        = "pd-ssd"
sap_nw_autodelete_boot_disk  = true
sap_nw_usrsap_disk_size      = 50
sap_nw_swap_disk_size        = 28
sap_nw_usrsap_disk_type      = "pd-ssd"
sap_nw_swap_disk_type        = "pd-ssd"
sap_nw_service_account_email = "811811474621-compute@developer.gserviceaccount.com"
sap_nw_network_tags          = ["sap-allow-all"]
sap_nw_pd_kms_key            = "projects/sap-iac-test/locations/global/keyRings/paypal-ring/cryptoKeys/paypal-key"
sap_nw_labels = {
  app = "nw"
}
sap_nw_alias_ip = ["10.5.0.16"]