terraform {
  required_version = ">= 0.12"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 3.53"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 3.53"
    }
    template = {
      source = "hashicorp/template"
    }
  }
}
