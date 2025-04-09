project_id           = "sap-iac-test"
subnetwork           = "app"
subnetwork_project   = "sap-iac-test"
source_image_name    = "rhel-8-8-sap-v20241210"
source_image_project = "rhel-sap-cloud"
gce_ssh_user         = "mahekar"
gce_ssh_pub_key_file = "~/.ssh/id_ecdsa.pub"

primary_zone   = "us-west1-a"
secondary_zone = "us-west1-b"

sap_nw_dr_ascs_instance_name         = "uswbwhascs01"
sap_nw_dr_ascs_instance_ip           = "10.1.0.11"
sap_nw_dr_ascs_instance_type         = "n2-standard-8"
sap_nw_dr_ascs_boot_disk_size        = 50
sap_nw_dr_ascs_boot_disk_type        = "pd-ssd"
sap_nw_dr_ascs_autodelete_boot_disk  = true # Do not change
sap_nw_dr_ascs_usrsap_disk_size      = 50
sap_nw_dr_ascs_swap_disk_size        = 30
sap_nw_dr_ascs_usrsap_disk_type      = "pd-ssd"
sap_nw_dr_ascs_swap_disk_type        = "pd-ssd"
sap_nw_dr_ascs_service_account_email = "811811474621-compute@developer.gserviceaccount.com"
sap_nw_dr_ascs_network_tags          = ["sap-allow-all-poc"]
sap_nw_dr_ascs_pd_kms_key            = "projects/sap-iac-test/locations/global/keyRings/paypal-ring/cryptoKeys/paypal-key"
sap_nw_dr_ascs_labels = {
  env = "prod"
}
sap_nw_dr_ascs_create_instance_group = true
sap_nw_dr_ascs_instance_group_name   = "paypal-sap-dr-instgrp-ascs-001"
sap_nw_dr_ascs_alias_ip              = ""
sap_nw_dr_ascs_named_ports = [{
  name = "paypal-sap-dr-ascs-health-check-port"
  port = 62001
}]


sap_nw_dr_ers_instance_name         = "uscdrers01"
sap_nw_dr_ers_instance_ip           = "10.1.0.12"
sap_nw_dr_ers_instance_type         = "n2-standard-8"
sap_nw_dr_ers_boot_disk_size        = 50
sap_nw_dr_ers_boot_disk_type        = "pd-ssd"
sap_nw_dr_ers_autodelete_boot_disk  = true
sap_nw_dr_ers_usrsap_disk_size      = 50
sap_nw_dr_ers_swap_disk_size        = 30
sap_nw_dr_ers_usrsap_disk_type      = "pd-ssd"
sap_nw_dr_ers_swap_disk_type        = "pd-ssd"
sap_nw_dr_ers_service_account_email = "811811474621-compute@developer.gserviceaccount.com"
sap_nw_dr_ers_network_tags          = ["sap-allow-all-poc"]
sap_nw_dr_ers_pd_kms_key            = "projects/sap-iac-test/locations/global/keyRings/paypal-ring/cryptoKeys/paypal-key"
sap_nw_dr_ers_labels = {
  env = "prod"
}
sap_nw_dr_ers_create_instance_group = true # Do not change
sap_nw_dr_ers_instance_group_name   = "paypal-sap-dr-instgrp-ers-001"
sap_nw_dr_ers_alias_ip              = ""
sap_nw_dr_ers_named_ports = [{
  name = "paypal-sap-dr-ers-health-check-port"
  port = 62110
}]


## ASCS ILB Variables
network_project                       = "sap-iac-test"
sap_nw_dr_ascs_ilb_name               = "paypal-sap-dr-ilb-ascs-00001"
sap_nw_dr_ascs_health_check_port      = 62001
sap_nw_dr_ascs_health_check_port_name = "paypal-sap-dr-ascs-health-check-port"
sap_nw_dr_ascs_ilb_ip_address         = "10.1.0.13"
sap_nw_dr_ascs_health_check_name      = "paypal-sap-dr-hlthchk-ascs-001"
sap_nw_dr_ascs_backend_service_name   = "paypal-sap-dr-backend-ascs-001"

## ERS ILB Variables
sap_nw_dr_ers_ilb_name               = "paypal-sap-dr-ilb-ers-0001"
sap_nw_dr_ers_health_check_port      = 62110
sap_nw_dr_ers_health_check_port_name = "paypal-sap-dr-ers-health-check-port"
sap_nw_dr_ers_ilb_ip_address         = "10.1.0.14"
sap_nw_dr_ers_health_check_name      = "paypal-sap-dr-hlthchk-ers-001"
sap_nw_dr_ers_backend_service_name   = "paypal-sap-dr-backend-ers-001"