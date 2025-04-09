locals {
  region = join("-", slice(split("-", var.zone_a), 0, 2))
}

data "terraform_remote_state" "umig" {
  backend = "gcs"
  config = {
    bucket = "${var.tf_state_bucket}"
    prefix = "${var.tf_state_bucket_instance_prefix}"
  }
}

resource "google_compute_region_ssl_certificate" "web" {
  project     = var.project_id
  region      = local.region
  name_prefix = "sap-web-${var.env}-ssl-certificate-${lower(var.webdisp_sid)}"
  private_key = file("${path.module}/files/${var.env}/webdisp_${var.env}_private_${var.webdisp_sid}.pem")
  certificate = file("${path.module}/files/${var.env}/webdisp_${var.env}_certificate_${var.webdisp_sid}.crt")

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_address" "gcp_sap_nw_intip" {
  name         = "sap-web-${var.env}-lb-${lower(var.webdisp_sid)}-hc"
  address_type = "INTERNAL"
  subnetwork   = "projects/${var.subnetwork_project}/regions/${local.region}/subnetworks/${var.subnetwork}"
  region       = local.region
  project      = var.project_id
  purpose      = "GCE_ENDPOINT"
  address      = var.glb_address_1

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_region_target_https_proxy" "default" {
  project          = var.project_id
  region           = local.region
  name             = "sap-web-${var.env}-lb-https-proxy-${lower(var.webdisp_sid)}"
  description      = "Regional HTTPS proxy"
  url_map          = google_compute_region_url_map.default.id
  ssl_certificates = google_compute_region_ssl_certificate.web.*.self_link

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_region_url_map" "default" {
  project         = var.project_id
  region          = local.region
  name            = "sap-web-${var.env}-${lower(var.webdisp_sid)}-lb"
  description     = "Regional URL map"
  default_service = google_compute_region_backend_service.default.id

  path_matcher {
    name            = "allpaths"
    default_service = google_compute_region_backend_service.default.id

    path_rule {
      paths   = ["/*"]
      service = google_compute_region_backend_service.default.id
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_region_backend_service" "default" {
  project                         = var.project_id
  region                          = local.region
  name                            = "sap-web-${var.env}-${lower(var.webdisp_sid)}-backend"
  port_name                       = var.web_port_name
  protocol                        = "HTTPS"
  timeout_sec                     = 125
  connection_draining_timeout_sec = 300
  load_balancing_scheme           = "INTERNAL_MANAGED"
  session_affinity                = "GENERATED_COOKIE"
  locality_lb_policy              = "MAGLEV"

  backend {
    group           = data.terraform_remote_state.umig.outputs.umig_a_self_links.0
    balancing_mode  = "UTILIZATION"
    capacity_scaler = 1
    max_utilization = 0.8
  }
  backend {
    group           = data.terraform_remote_state.umig.outputs.umig_b_self_links.0
    balancing_mode  = "UTILIZATION"
    capacity_scaler = 1
    max_utilization = 0.8
  }

  health_checks = [google_compute_region_health_check.default.id]

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_region_health_check" "default" {
  name               = "sap-web-${var.env}-lb-${lower(var.webdisp_sid)}-hc"
  description        = "Healthcheck for LB backend"
  region             = local.region
  project            = var.project_id
  check_interval_sec = 5
  timeout_sec        = 5

  tcp_health_check {
    port_name = var.web_port_name
    port      = 44380
    # request_path = "/healthcheck"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_forwarding_rule" "default" {
  name                  = "sap-web-${var.env}-forwarding-rule-${lower(var.webdisp_sid)}"
  project               = var.project_id
  region                = local.region
  ip_address            = google_compute_address.gcp_sap_nw_intip.address
  ip_protocol           = "TCP"
  load_balancing_scheme = "INTERNAL_MANAGED"
  allow_global_access   = true
  port_range            = "443"
  target                = google_compute_region_target_https_proxy.default.id
  subnetwork            = "projects/${var.subnetwork_project}/regions/${local.region}/subnetworks/${var.subnetwork}"
  network_tier          = "PREMIUM"

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_instance_group_named_port" "umig_a_named_port" {
  name  = var.web_port_name
  port  = 8080
  group = data.terraform_remote_state.umig.outputs.umig_a_self_links.0
  zone  = var.zone_a

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_instance_group_named_port" "umig_a_named_port_1" {
  name  = var.web_port_name
  port  = 44380
  group = data.terraform_remote_state.umig.outputs.umig_a_self_links.0
  zone  = var.zone_a

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_instance_group_named_port" "umig_b_named_port" {
  name  = var.web_port_name
  port  = 8080
  group = data.terraform_remote_state.umig.outputs.umig_b_self_links.0
  zone  = var.zone_a

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_instance_group_named_port" "umig_b_named_port_1" {
  name  = var.web_port_name
  port  = 44380
  group = data.terraform_remote_state.umig.outputs.umig_b_self_links.0
  zone  = var.zone_a

  lifecycle {
    create_before_destroy = true
  }
}