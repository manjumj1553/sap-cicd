project_id           = "sap-iac-test"
subnetwork           = "db-central"
subnetwork_project   = "sap-iac-test"
source_image_name    = "rhel-9-2-sap-v20241210"
source_image_project = "rhel-sap-cloud"
gce_ssh_user         = "mahekar"
gce_ssh_pub_key_file = "~/.ssh/id_rsa.pub"

sap_hana_primary_zone                 = "us-central1-a"
sap_hana_primary_instance_name        = "mjh3pdbvm01"
sap_hana_primary_instance_ip          = "10.5.0.101"
sap_hana_primary_instance_type        = "n1-highmem-32"
sap_hana_primary_boot_disk_size       = 50
sap_hana_primary_boot_disk_type       = "pd-ssd"
sap_hana_primary_autodelete_boot_disk = true
sap_hana_primary_data_disk_size       = 10
sap_hana_primary_log_disk_size        = 10
sap_hana_primary_shared_disk_size     = 10
sap_hana_primary_usrsap_disk_size     = 10
sap_hana_primary_swap_disk_size       = 2
sap_hana_primary_data_disk_type       = "pd-ssd"
sap_hana_primary_log_disk_type        = "pd-ssd"
sap_hana_primary_shared_disk_type     = "pd-ssd"
sap_hana_primary_usrsap_disk_type     = "pd-ssd"
sap_hana_primary_swap_disk_type       = "pd-ssd"
sap_hana_primary_addon_disks = {
  name         = ["lssshared"]
  disk_size_gb = [10]
  disk_type    = ["pd-ssd"]
}
sap_hana_primary_service_account_email = "811811474621-compute@developer.gserviceaccount.com"
sap_hana_primary_network_tags          = ["sap-allow-all"]
sap_hana_primary_pd_kms_key            = "projects/sap-iac-test/locations/global/keyRings/paypal-ring/cryptoKeys/paypal-key"
sap_hana_primary_labels = {
  app = "hana-primary"
}
sap_hana_primary_instance_group_name = "paypal-sap-h3p-instgrp-db-001"
sap_hana_primary_named_ports = [{
  name = "paypal-sap-h3p-health-check-port"
  port = 60000
}]


sap_hana_secondary_zone                 = "us-central1-b"
sap_hana_secondary_instance_name        = "mjh3pdbvm02"
sap_hana_secondary_instance_ip          = "10.5.0.102"
sap_hana_secondary_instance_type        = "n1-standard-8"
sap_hana_secondary_boot_disk_size       = 50
sap_hana_secondary_boot_disk_type       = "pd-ssd"
sap_hana_secondary_autodelete_boot_disk = true
sap_hana_secondary_data_disk_size       = 10
sap_hana_secondary_log_disk_size        = 10
sap_hana_secondary_shared_disk_size     = 10
sap_hana_secondary_usrsap_disk_size     = 10
sap_hana_secondary_swap_disk_size       = 2
sap_hana_secondary_data_disk_type       = "pd-ssd"
sap_hana_secondary_log_disk_type        = "pd-ssd"
sap_hana_secondary_shared_disk_type     = "pd-ssd"
sap_hana_secondary_usrsap_disk_type     = "pd-ssd"
sap_hana_secondary_swap_disk_type       = "pd-ssd"
sap_hana_secondary_addon_disks = {
  name         = ["lssshared"]
  disk_size_gb = [10]
  disk_type    = ["pd-ssd"]
}
sap_hana_secondary_service_account_email = "811811474621-compute@developer.gserviceaccount.com"
sap_hana_secondary_network_tags          = ["sap-allow-all"]
sap_hana_secondary_pd_kms_key            = "projects/sap-iac-test/locations/global/keyRings/paypal-ring/cryptoKeys/paypal-key"
sap_hana_secondary_labels = {
  app = "hana-secondary"
}
sap_hana_secondary_instance_group_name = "paypal-sap-h3p-instgrp-db-002"
sap_hana_secondary_named_ports = [{
  name = "paypal-sap-h3p-health-check-port"
  port = 60000
}]


network_project                 = "sap-iac-test"
sap_hana_ilb_name               = "paypal-sap-h3p-tcplb-dbvip-001"
sap_hana_health_check_port      = 60000
sap_hana_health_check_port_name = "paypal-sap-h3p-health-check-port"
sap_hana_ilb_ip_address         = "10.5.0.104"
sap_hana_health_check_name      = "paypal-sap-h3p-hlthchk-dbvip-001"
sap_hana_backend_service_name   = "paypal-sap-h3p-backend-dbvip-001"