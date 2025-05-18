variable "org_id" {
  description = "The organization ID for the GCP project"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the Azure resource group."
  type        = string
}

variable "billing_id" {
  description = "The billing account ID for the GCP project"
  type        = string
}

variable "sql_server_name" {
  description = "The name of the Azure SQL Server."
  type        = string
}

variable "sql_db_name" {
  description = "The name of the Azure SQL Database."
  type        = string
  default     = "BigQueryDemo"
}

variable "sql_admin_username" {
  description = "The administrator username for the Azure SQL Server."
  type        = string
}

variable "sql_admin_password" {
  description = "The administrator password for the Azure SQL Server."
  type        = string
  sensitive   = true
}

variable "gcp_project_id" {
  description = "The GCP project ID."
  type        = string
}
variable "azure_client_id" {
  description = "The Azure client ID."
  type        = string
}
variable "azure_subscription_id" {
  description = "The Azure subscription ID."
  type        = string
}
variable "azure_tenant_id" {
  description = "The Azure tenant ID."
  type        = string
}

variable "gcp_bucket_name" {
  description = "The name of the GCP bucket."
  type        = string
  default     = "pick2-etl-rawfiles"
}