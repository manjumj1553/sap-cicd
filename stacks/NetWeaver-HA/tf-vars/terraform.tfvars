project_id               = "sap-iac-test"
subnetwork_nw            = "db-central"
gce_ssh_user             = "mahekar"
gce_ssh_pub_key_file     = "~/.ssh/id_ecdsa.pub"
source_nw_image_name     = "rhel-9-2-sap-v20241210"
source_nw_image_project  = "rhel-sap-cloud"
nw_instance_type         = "n2-standard-8"
nw_boot_disk_size        = 50
nw_boot_disk_type        = "pd-balanced"
nw_usrsap_disk_size      = 100
nw_swap_disk_size        = 30
nw_usrsap_disk_type      = "pd-balanced"
nw_swap_disk_type        = "pd-balanced"
nw_autodelete_boot_disk  = true
nw_network_tags          = ["sap-allow-all"]
nw_service_account_email = "811811474621-compute@developer.gserviceaccount.com"
create_instance_group    = true
nw_pd_kms_key            = "projects/sap-iac-test/locations/global/keyRings/paypal-ring/cryptoKeys/paypal-key"

ascs_instance_name       = "nhdxdascs00"
ascs_instance_ip         = "10.5.0.131"
primary_zone             = "us-central1-a"
ascs_instance_group_name = "paypal-sap-dxd1-poc-instgrp-ascs-001"
ascs_health_check_port   = 62001
nw_ascs_labels = {
  env = "prod"
}

ers_instance_name       = "nhdxders00"
ers_instance_ip         = "10.5.0.132"
secondary_zone          = "us-central1-b"
ers_instance_group_name = "paypal-sap-dxd1-poc-instgrp-ers-002"
ers_health_check_port   = 62110
nw_ers_labels = {
  env = "prod"
}

pas_instance_name       = "nhdxdpas00"
pas_instance_ip         = "10.5.0.133"
nw_as_instance_type     = "n2-standard-4"
pas_boot_disk_type      = "pd-balanced"
nw_pas_usrsap_disk_size = 100
nw_pas_swap_disk_size   = 30
pas_usrsap_disk_type    = "pd-balanced"
pas_swap_disk_type      = "pd-balanced"
pas_alias_ip            = "10.5.0.134"
nw_pas_labels = {
  env = "prod"
}

ascs_ilb_name             = "paypal-sap-dxd1-poc-ilb-ascs-001"
ascs_ilb_ip               = "10.5.0.135"
ascs_health_check_name    = "paypal-sap-dxd1-poc-hlthchk-ascs-001"
ascs_backend_service_name = "paypal-sap-dxd1-poc-backend-ascs-001"

ers_ilb_name             = "paypal-sap-dxd1-poc-ilb-ers-001"
ers_ilb_ip               = "10.5.0.136"
ers_health_check_name    = "paypal-sap-dxd1-poc-hlthchk-ers-001"
ers_backend_service_name = "paypal-sap-dxd1-poc-backend-ers-001"