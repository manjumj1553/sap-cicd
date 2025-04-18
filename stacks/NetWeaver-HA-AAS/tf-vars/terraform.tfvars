nw_aas_instance_name_a   = ["nwemqaasvm01", "nwemqaasvm02"]
nw_aas_instance_ip_a     = ["10.5.0.161", "10.5.0.162"]
zone_a                   = "us-central1-a"
prefix_a                 = "nwemqaasvma"
prefix_b                 = "nwemqaasvmb"
nw_aas_instance_name_b   = ["nwemqaasvm03", "nwemqaasvm04"]
nw_aas_instance_ip_b     = ["10.5.0.163", "10.5.0.164"]
zone_b                   = "us-central1-b"
project_id               = "sap-iac-test"
gce_ssh_user             = "mahekar"
gce_ssh_pub_key_file     = "~/.ssh/id_ecdsa.pub"
subnetwork_nw            = "db-central"
source_nw_image_name     = "rhel-9-2-sap-v20241210"
source_nw_image_project  = "rhel-sap-cloud"
nw_aas_usrsap_disk_size  = 100
nw_aas_swap_disk_size    = 30
nw_aas_instance_type     = "n2-standard-2"
nw_aas_boot_disk_size    = 50
nw_aas_boot_disk_type    = "pd-balanced"
nw_aas_usrsap_disk_type  = "pd-balanced"
nw_aas_swap_disk_type    = "pd-balanced"
nw_autodelete_boot_disk  = true
nw_aas_network_tags      = ["sap-allow-all"]
nw_service_account_email = "811811474621-compute@developer.gserviceaccount.com"
nw_aas_alias_ip_a        = ["10.5.0.165", "10.5.0.166"]
nw_aas_alias_ip_b        = ["10.5.0.167", "10.5.0.168"]
nw_pd_kms_key            = "projects/sap-iac-test/locations/global/keyRings/paypal-ring/cryptoKeys/paypal-key"
nw_aas_labels = {
  env = "prod"
}