project_id           = "sap-iac-test"
subnetwork           = "db-central"
subnetwork_project   = "sap-iac-test"
source_image_name    = "rhel-9-2-sap-v20241210"
source_image_project = "rhel-sap-cloud"
gce_ssh_user         = "mahekar"
gce_ssh_pub_key_file = "~/.ssh/id_ecdsa.pub"

primary_zone   = "us-central1-a"
secondary_zone = "us-central1-b"

sap_nw_ascs_instance_name         = "uscbwhascs01"
sap_nw_ascs_instance_ip           = "10.5.0.131"
sap_nw_ascs_instance_type         = "n2-standard-8"
sap_nw_ascs_boot_disk_size        = 50
sap_nw_ascs_boot_disk_type        = "pd-ssd"
sap_nw_ascs_autodelete_boot_disk  = true
sap_nw_ascs_usrsap_disk_size      = 100
sap_nw_ascs_swap_disk_size        = 30
sap_nw_ascs_usrsap_disk_type      = "pd-ssd"
sap_nw_ascs_swap_disk_type        = "pd-ssd"
sap_nw_ascs_service_account_email = "811811474621-compute@developer.gserviceaccount.com"
sap_nw_ascs_network_tags          = ["sap-allow-all-poc"]
sap_nw_ascs_pd_kms_key            = "projects/sap-iac-test/locations/global/keyRings/paypal-ring/cryptoKeys/paypal-key"
sap_nw_ascs_labels = {
  env = "prod"
}
sap_nw_ascs_create_instance_group = true
sap_nw_ascs_instance_group_name   = "paypal-sap-bwh-instgrp-ascs-001"
sap_nw_ascs_alias_ip              = ""
sap_nw_ascs_named_ports = [{
  name = "paypal-sap-bwh-ascs-health-check-port"
  port = 62001
}]

sap_nw_ers_instance_name         = "uscbwhers01"
sap_nw_ers_instance_ip           = "10.5.0.132"
sap_nw_ers_instance_type         = "n2-standard-8"
sap_nw_ers_boot_disk_size        = 50
sap_nw_ers_boot_disk_type        = "pd-ssd"
sap_nw_ers_autodelete_boot_disk  = true
sap_nw_ers_usrsap_disk_size      = 110
sap_nw_ers_swap_disk_size        = 30
sap_nw_ers_usrsap_disk_type      = "pd-ssd"
sap_nw_ers_swap_disk_type        = "pd-ssd"
sap_nw_ers_service_account_email = "811811474621-compute@developer.gserviceaccount.com"
sap_nw_ers_network_tags          = ["sap-allow-all-poc"]
sap_nw_ers_pd_kms_key            = "projects/sap-iac-test/locations/global/keyRings/paypal-ring/cryptoKeys/paypal-key"
sap_nw_ers_labels = {
  env = "prod"
}
sap_nw_ers_create_instance_group = true
sap_nw_ers_instance_group_name   = "paypal-sap-bwh-instgrp-ers-001"
sap_nw_ers_alias_ip              = ""
sap_nw_ers_named_ports = [{
  name = "paypal-sap-bwh-ers-health-check-port"
  port = 62110
}]

sap_nw_pas_instance_name         = "uscbwhpas01"
sap_nw_pas_instance_ip           = "10.5.0.133"
sap_nw_pas_instance_type         = "n2-standard-8"
sap_nw_pas_boot_disk_size        = 50
sap_nw_pas_boot_disk_type        = "pd-ssd"
sap_nw_pas_autodelete_boot_disk  = true
sap_nw_pas_usrsap_disk_size      = 100
sap_nw_pas_swap_disk_size        = 30
sap_nw_pas_usrsap_disk_type      = "pd-ssd"
sap_nw_pas_swap_disk_type        = "pd-ssd"
sap_nw_pas_service_account_email = "811811474621-compute@developer.gserviceaccount.com"
sap_nw_pas_network_tags          = ["sap-allow-all"]
sap_nw_pas_pd_kms_key            = "projects/sap-iac-test/locations/global/keyRings/paypal-ring/cryptoKeys/paypal-key"
sap_nw_pas_labels = {
  env = "prod"
  app = "pas"
}
sap_nw_pas_create_instance_group = false
sap_nw_pas_instance_group_name   = ""
sap_nw_pas_alias_ip              = "10.5.0.134"

## ASCS ILB Variables
network_project                    = "sap-iac-test"
sap_nw_ascs_ilb_name               = "paypal-sap-bwh-ilb-ascs-001"
sap_nw_ascs_health_check_port      = 62001
sap_nw_ascs_health_check_port_name = "paypal-sap-bwh-ascs-health-check-port"
sap_nw_ascs_ilb_ip_address         = "10.5.0.135"
sap_nw_ascs_health_check_name      = "paypal-sap-bwh-hlthchk-ascs-001"
sap_nw_ascs_backend_service_name   = "paypal-sap-bwh-backend-ascs-001"

## ERS ILB Variables
sap_nw_ers_ilb_name               = "paypal-sap-bwh-ilb-ers-001"
sap_nw_ers_health_check_port      = 62110
sap_nw_ers_health_check_port_name = "paypal-sap-bwh-ers-health-check-port"
sap_nw_ers_ilb_ip_address         = "10.5.0.136"
sap_nw_ers_health_check_name      = "paypal-sap-bwh-hlthchk-ers-001"
sap_nw_ers_backend_service_name   = "paypal-sap-bwh-backend-ers-001"