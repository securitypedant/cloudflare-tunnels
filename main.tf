module "gcp_server" {
  source = "./modules/gcp"

  name = "sandbox-server"
  machine_type = var.gcp_machine_type
  image = var.gcp_instance_image
}

module "cloudflare_tunnel" {
  source = "./modules/cloudflare/tunnel"

  name = "terraform"
  cloudflare_account_id = var.cloudflare_account_id
  cloudflare_zone_id    = var.cloudflare_zone_id
  cloudflare_zone       = var.cloudflare_zone

}