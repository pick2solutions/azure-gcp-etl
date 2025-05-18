data "google_project" "project" {
  project_id = var.gcp_project_id
}

## ------
## Enable GCP Artifact Registry
## ------
resource "google_artifact_registry_repository" "repo" {
  location      = "us-central1"
  repository_id = "pick2-bigquery-demo"
  description   = "Docker Repository"
  format        = "DOCKER"
  project       = data.google_project.project.project_id

  docker_config {
    immutable_tags = false
  }
}


## ------
## Add IAM binding.
## ------
data "google_service_account" "sa" {
  account_id = "bigquery-pipeline-demo"
  project    = data.google_project.project.project_id
}

resource "google_artifact_registry_repository_iam_binding" "binding" {
  project = google_artifact_registry_repository.repo.project
  location = google_artifact_registry_repository.repo.location
  repository = google_artifact_registry_repository.repo.name
  role = "roles/artifactregistry.repoAdmin"
  members = [
    "serviceAccount:${data.google_service_account.sa.email}",
  ]
}