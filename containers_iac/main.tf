data "google_project" "project" {
  project_id = var.gcp_project_id
}

## ------
## Enable GCP APIs
## ------
resource "google_project_iam_member" "serviceusage_viewer" {
  project = data.google_project.project.project_id
  role    = "roles/serviceusage.viewer"
  member  = "serviceAccount:${data.google_service_account.sa.email}"
}

resource "google_project_service" "enabled_apis" {
  for_each = toset(local.gcp_services)
  project  = data.google_project.project.project_id
  service  = each.key
  depends_on = [ google_project_iam_member.serviceusage_viewer ]
}

## ------
## Enable GCP Artifact Registry
## ------
resource "google_artifact_registry_repository" "repo" {
  location      = "us-central1"
  repository_id = "pick2-etl-demo"
  description   = "Docker Repository"
  format        = "DOCKER"
  project       = data.google_project.project.project_id

  docker_config {
    immutable_tags = false
  }
  depends_on = [google_project_service.enabled_apis]
}


## ------
## Add IAM binding.
## ------
data "google_service_account" "sa" {
  account_id = "github-actions"
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