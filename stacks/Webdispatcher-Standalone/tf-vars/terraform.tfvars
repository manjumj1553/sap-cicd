
project_id                   = "sap-iac-test"
subnetwork                   = "db-central"
subnetwork_project           = "sap-iac-test"
source_image_name            = "rhel-9-2-sap-v20241210"
source_image_project         = "rhel-sap-cloud"
gce_ssh_user                 = "mahekar"
gce_ssh_pub_key_file         = "~/.ssh/id_ecdsa.pub"
sap_nw_zone                  = "us-central1-a"
sap_nw_instance_name         = "webdispsa1"
sap_nw_instance_ip           = "10.5.0.69"
sap_nw_instance_type         = "n1-standard-2"
sap_nw_boot_disk_size        = 50
sap_nw_boot_disk_type        = "pd-ssd"
sap_nw_autodelete_boot_disk  = true
sap_nw_usrsap_disk_size      = 10
sap_nw_usrsap_disk_type      = "pd-ssd"
sap_nw_create_instance_group = false #Do not modify
sap_nw_instance_group_name   = ""    #Do not modify
sap_nw_service_account_email = "811811474621-compute@developer.gserviceaccount.com"
sap_nw_network_tags          = ["sap-allow-all"]
sap_nw_pd_kms_key            = "projects/sap-iac-test/locations/global/keyRings/paypal-ring/cryptoKeys/paypal-key"
sap_nw_labels = {
  env = "prod"
}