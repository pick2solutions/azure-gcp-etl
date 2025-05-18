locals {
  gcp_services = [
    "bigquery.googleapis.com",
    "storage.googleapis.com",
    "run.googleapis.com",
    "cloudfunctions.googleapis.com",
    "cloudbuild.googleapis.com",
    "eventarc.googleapis.com"
  ]
}