project_id           = "sap-iac-test"
subnetwork           = "db-central"
subnetwork_project   = "sap-iac-test"
source_image_name    = "sles-15-sp5-sap-v20250221-x86-64"
source_image_project = "suse-sap-cloud"
gce_ssh_user         = "mahekar"
gce_ssh_pub_key_file = "~/.ssh/id_rsa.pub"

sap_hana_zone                  = "us-central1-a"
sap_hana_master_node_name      = "usch3phdbm"
sap_hana_worker_node_names     = ["usch3phdbw1", "usch3phdbw2"]
sap_hana_master_instance_ip    = "10.5.0.51"
sap_hana_worker_instance_ips   = ["10.5.0.52", "10.5.0.53"]
sap_hana_instance_type         = "n1-highmem-32"
sap_hana_use_public_ip         = false # Do not change
sap_hana_boot_disk_size        = 20
sap_hana_boot_disk_type        = "pd-ssd"
sap_hana_autodelete_boot_disk  = true # Do not change
sap_hana_data_disk_size        = 249
sap_hana_log_disk_size         = 104
sap_hana_usrsap_disk_size      = 32
sap_hana_swap_disk_size        = 2
sap_hana_data_disk_type        = "pd-ssd"
sap_hana_log_disk_type         = "pd-ssd"
sap_hana_usrsap_disk_type      = "pd-ssd"
sap_hana_swap_disk_type        = "pd-ssd"
sap_hana_addon_disks = {
  name         = []
  disk_size_gb = []
  disk_type    = []
}
sap_hana_service_account_email = "811811474621-compute@developer.gserviceaccount.com"
sap_hana_network_tags          = ["sap-allow-all"]
sap_hana_pd_kms_key            = "projects/sap-iac-test/locations/global/keyRings/paypal-ring/cryptoKeys/paypal-key"
sap_hana_labels = {
  app = "hana"
}
