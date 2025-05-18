# Deploy the export function that pulls from Azure SQL and writes to GCS
resource "google_cloud_run_v2_job" "azure_to_gcs" {
  name     = "azure-to-gcs"
  location = "us-central1"
  deletion_protection = false
  template {
    template{
      containers {
      image = "us-central1-docker.pkg.dev/${data.google_project.project.project_id}/pick2-etl-demo/azure-to-gcs"
      env {
        name = "AZURE_SQL_SERVER"   
        value = "${var.sql_server_name}.database.windows.net"
      }
      env {
        name = "AZURE_SQL_DATABASE"
        value = var.sql_db_name
      }
      env {
        name = "AZURE_SQL_USER"
        value = var.sql_admin_username
      }
      env {
        name = "AZURE_SQL_PASSWORD"
        value = var.sql_admin_password
      }
      env {
        name = "TARGET_BUCKET"
        value = var.gcp_bucket_name
      }
    }
    }
  }
}

resource "google_cloud_run_v2_job" "gcs_to_bq" {
  name     = "gcs-to-bq"
  location = "us-central1"
  deletion_protection = false

  template {
    template {
      containers {
        image = "us-central1-docker.pkg.dev/${data.google_project.project.project_id}/pick2-etl-demo/gcs-to-bq"
      }
    }
  }
}

resource "google_project_iam_member" "gcs_pubsub_publisher_role" {
  project = data.google_project.project.project_id
  role    = "roles/pubsub.publisher"
  member  = "serviceAccount:service-${data.google_project.project.number}@gs-project-accounts.iam.gserviceaccount.com"
}
