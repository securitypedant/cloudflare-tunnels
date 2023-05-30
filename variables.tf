# Cloudflare
variable "cloudflare_zone" {
  type = string
}

variable "cloudflare_zone_id" {
  type = string
}

variable "cloudflare_account_id" {
  type = string
}

variable "cloudflare_email" {
  type = string
}

variable "cloudflare_key" {
  type = string
}

# Google
variable "gcp_project_id" {
  type = string
}

variable "gcp_machine_type" {
  type = string
  default = "e2-micro"
}

variable "gcp_zone" {
  type = string
}

variable "gcp_region" {
  type = string
}

variable "gcp_instance_image" {
    type = string
    default = "debian-cloud/debian-11"
}

variable "gcp_creds_file" {
  type = string
}
