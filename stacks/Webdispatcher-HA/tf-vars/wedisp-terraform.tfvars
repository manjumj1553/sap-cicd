
project_id                   = "sap-iac-test"
subnetwork_nw                = "db-central"
subnetwork_project           = "sap-iac-test"
source_image_name            = "rhel-9-2-sap-v20241210"
source_image_project         = "rhel-sap-cloud"
sap_nw_autodelete_boot_disk  = true
sap_nw_use_public_ip         = false
sap_nw_instance_type         = "n2-standard-2"
sap_nw_network_tags          = ["sap-allow-all"]
sap_nw_boot_disk_size        = 50
sap_nw_boot_disk_type        = "pd-ssd"
sap_nw_additional_disk_type  = "pd-ssd"
sap_nw_service_account_email = "811811474621-compute@developer.gserviceaccount.com"
gce_ssh_user                 = "mahekar"
gce_ssh_pub_key_file         = "~/.ssh/id_ecdsa.pub"
nw_script_path               = ""
sap_nw_pd_kms_key            = "projects/sap-iac-test/locations/global/keyRings/paypal-ring/cryptoKeys/paypal-key"
sap_nw_usrsap_disk_size      = 100

sap_nw_primary_instance_name       = "uscwd1app01"
sap_nw_primary_instance_ip         = "10.5.0.44"
sap_nw_primary_zone                = "us-central1-a"
sap_nw_primary_instance_group_name = "paypal-sap-webdisp-instgrp-nw-001"
sap_nw_primary_labels = {
  env = "prod"
}


sap_nw_secondary_instance_name       = "uscwd2app02"
sap_nw_secondary_instance_ip         = "10.5.0.45"
sap_nw_secondary_zone                = "us-central1-b"
sap_nw_secondary_instance_group_name = "paypal-sap-webdisp-instgrp-nw-002"
sap_nw_secondary_labels = {
  env = "prod"
}