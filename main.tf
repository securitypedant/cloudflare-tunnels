variable "servers" {
  default = {
    "server1" = {
      name = "terraform1"
    },
    "server2" = {
      name = "terraform2"
    }
  }   
}

module "cloudflare_tunnel" {
  source = "./modules/cloudflare/tunnel"
  for_each = var.servers

  name = each.value.name
  cloudflare_account_id = var.cloudflare_account_id
  cloudflare_zone_id    = var.cloudflare_zone_id
  cloudflare_zone       = var.cloudflare_zone
}

module "gcp_server" {
  source = "./modules/gcp"
  for_each = var.servers

  name = each.value.name
  startup_script = "server-setup.sh"
  cloudflare_tunnel_token = module.cloudflare_tunnel[each.key].tunnel_token
  machine_type = var.gcp_machine_type
  image = var.gcp_instance_image
}
