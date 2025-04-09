
project_id                     = "sap-iac-test"
source_image_name              = "rhel-9-2-sap-v20241210"
source_image_project           = "rhel-sap-cloud"
sap_hana_install_files_bucket  = "sap-deployment-media"
sap_hana_instance_type         = "n1-highmem-32"
sap_hana_boot_disk_size        = 50
sap_hana_boot_disk_type        = "pd-balanced"
sap_hana_service_account_email = "811811474621-compute@developer.gserviceaccount.com"
sap_hana_additional_disk_type  = "pd-balanced"
sap_hana_data_size             = 500
sap_hana_log_size              = 300
sap_hana_shared_size           = 500
sap_hana_usr_size              = 50
sap_hana_swap_size             = 2
sap_hana_log_disk_type         = "pd-balanced"
sap_hana_data_disk_type        = "pd-balanced"
sap_hana_shared_disk_type      = "pd-balanced"
sap_hana_usr_disk_type         = "pd-balanced"
sap_hana_swap_disk_type        = "pd-balanced"
subnetwork_hana                = "db-central"
sap_hana_network_tags          = ["sap-allow-all"]
subnetwork_project             = "sap-iac-test"
gce_ssh_user                   = "mahekar"
gce_ssh_pub_key_file           = "~/.ssh/id_ecdsa.pub"
sap_hana_autodelete_boot_disk  = true
sap_hana_pd_kms_key            = "projects/sap-iac-test/locations/global/keyRings/paypal-ring/cryptoKeys/paypal-key"
hana_script_path               = ""
nw_script_path                 = ""
sap_hana_addon_disks = {
  name         = []
  disk_size_gb = []
  disk_type    = []
}


sap_hana_primary_instance_name = "mjh3pdbvm01"
sap_hana_primary_instance_ip   = "10.5.0.101"
sap_hana_primary_zone          = "us-central1-a"
primary_instance_group_name    = "paypal-sap-h3p-instgrp-db-001"
sap_hana_primary_labels = {
  env = "prod"
}


sap_hana_secondary_instance_name = "mjh3pdbvm02"
sap_hana_secondary_instance_ip   = "10.5.0.102"
sap_hana_secondary_zone          = "us-central1-b"
secondary_instance_group_name    = "paypal-sap-h3p-instgrp-db-002"
sap_hana_secondary_labels = {
  env = "prod"
}


hana_ilb_ip_address    = "10.5.0.103"
hana_ilb_name          = "paypal-sap-h3p-tcplb-dbvip-001"
hana_health_check_name = "paypal-sap-h3p-hlthchk-dbvip-001"
backend_service_name   = "paypal-sap-h3p-backend-dbvip-001"
hana_health_check_port = 60000

