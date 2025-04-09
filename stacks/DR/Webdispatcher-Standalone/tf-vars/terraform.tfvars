project_id           = "sap-iac-test"
subnetwork           = "db-central"
subnetwork_project   = "sap-iac-test"
source_image_name    = "rhel-8-8-sap-v20241210"
source_image_project = "rhel-sap-cloud"
gce_ssh_user         = "mahekar"
gce_ssh_pub_key_file = "~/.ssh/id_rsa.pub"


sap_nw_dr_pas_zone                  = "us-central1-c"
sap_nw_dr_pas_instance_name         = "uscdrpas01"
sap_nw_dr_pas_instance_ip           = "10.5.0.113"
sap_nw_dr_pas_instance_type         = "n2-standard-4"
sap_nw_dr_pas_boot_disk_size        = 50
sap_nw_dr_pas_boot_disk_type        = "pd-ssd"
sap_nw_dr_pas_autodelete_boot_disk  = true # Do not change
sap_nw_dr_pas_usrsap_disk_size      = 50
sap_nw_dr_pas_swap_disk_size        = 30
sap_nw_dr_pas_usrsap_disk_type      = "pd-ssd"
sap_nw_dr_pas_swap_disk_type        = "pd-ssd"
sap_nw_dr_pas_service_account_email = "811811474621-compute@developer.gserviceaccount.com"
sap_nw_dr_pas_network_tags          = ["sap-allow-all"]
sap_nw_dr_pas_pd_kms_key            = "projects/sap-iac-test/locations/global/keyRings/paypal-ring/cryptoKeys/paypal-key"
sap_nw_dr_pas_labels = {
  app = "pas"
}
sap_nw_dr_pas_create_instance_group = false //Create Instance Group should always be false for PAS
sap_nw_dr_pas_instance_group_name   = ""    //Do not change
sap_nw_dr_pas_alias_ip              = "10.5.0.114"

sap_nw_pas_instance_name = "uscbwhpas01"
sap_nw_pas_zone          = "us-central1-a"