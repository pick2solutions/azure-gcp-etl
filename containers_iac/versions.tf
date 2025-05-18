terraform {
  required_version = ">= 1.11.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 6.35.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 6.35.0"
    }
  }
  backend "gcs" {
    bucket = "terraform-state-bq"
    prefix = "terraform/registry-state"
  }
}