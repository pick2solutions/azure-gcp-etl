data "google_project" "project" {
  project_id = var.gcp_project_id
}

## ------
## Enable GCP APIs
## ------
resource "google_project_service" "enabled_apis" {
  for_each = toset(local.gcp_services)
  project  = data.google_project.project.project_id
  service  = each.key
}

## ------
## BigQuery
## ------
module "bigquery" {
  source  = "terraform-google-modules/bigquery/google"
  version = "~> 10.1"

  dataset_id                  = "etl_dataset"
  dataset_name                = "ETL Dataset"
  description                 = "Dataset for ETL demo"
  project_id                  = data.google_project.project.project_id
  location                    = "US"
  default_table_expiration_ms = 3600000
}

## ------
## Cloud Storage - Files on GCP Side
## ------
resource "google_storage_bucket" "rawfiles" {
  name     = "pick2-etl-rawfiles"
  location = "us-central1"
  project  = data.google_project.project.project_id
}
