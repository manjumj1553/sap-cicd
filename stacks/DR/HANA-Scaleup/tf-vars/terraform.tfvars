project_id           = "sap-iac-test"
subnetwork           = "app"
subnetwork_project   = "sap-iac-test"
source_image_name    = "rhel-8-8-sap-v20241210"
source_image_project = "rhel-sap-cloud"
gce_ssh_user         = "mahekar"
gce_ssh_pub_key_file = "~/.ssh/id_rsa.pub"

sap_hana_dr_zone                 = "us-west1-a"
sap_hana_dr_instance_name        = "uswh8pdb01"
sap_hana_dr_instance_ip          = "10.1.0.10"
sap_hana_dr_instance_type        = "n1-highmem-32"
sap_hana_dr_use_public_ip        = false # Do not change
sap_hana_dr_boot_disk_size       = 50
sap_hana_dr_boot_disk_type       = "pd-ssd"
sap_hana_dr_autodelete_boot_disk = true # Do not change
sap_hana_dr_data_disk_size       = 50
sap_hana_dr_log_disk_size        = 50
sap_hana_dr_shared_disk_size     = 50
sap_hana_dr_usrsap_disk_size     = 32
sap_hana_dr_swap_disk_size       = 2
sap_hana_dr_data_disk_type       = "pd-ssd"
sap_hana_dr_log_disk_type        = "pd-ssd"
sap_hana_dr_shared_disk_type     = "pd-ssd"
sap_hana_dr_usrsap_disk_type     = "pd-ssd"
sap_hana_dr_swap_disk_type       = "pd-ssd"
sap_hana_dr_addon_disks = {
  name         = ["lssshared"]
  disk_size_gb = [50]
  disk_type    = ["pd-ssd"]
}
sap_hana_dr_service_account_email = "811811474621-compute@developer.gserviceaccount.com"
sap_hana_dr_network_tags          = ["sap-allow-all"]
sap_hana_dr_pd_kms_key            = "projects/sap-iac-test/locations/global/keyRings/paypal-ring/cryptoKeys/paypal-key"
sap_hana_dr_labels = {
  app = "hana"
}