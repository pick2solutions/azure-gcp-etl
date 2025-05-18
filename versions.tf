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
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.29.0"
    }
  }
  backend "gcs" {
    bucket = "pick2-terraform-state-etl"
    prefix = "terraform/state"
  }
}