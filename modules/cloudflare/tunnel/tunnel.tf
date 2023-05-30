# The random_id resource is used to generate a 35 character secret for the tunnel
resource "random_id" "tunnel_secret" {
  byte_length = 35
}

# A Named Tunnel resource
resource "cloudflare_tunnel" "tunnel" {
  account_id = "${var.cloudflare_account_id}"
  name       = "${var.name}"
  secret     = random_id.tunnel_secret.b64_std
}

# Tunnel configuration
resource "cloudflare_tunnel_config" "tunnel_config" {
  account_id = "${var.cloudflare_account_id}"
  tunnel_id  = cloudflare_tunnel.tunnel.id

  config {
    ingress_rule {
      service  = "http://server:80"
    }
  }
}

# DNS settings to CNAME to tunnel target
resource "cloudflare_record" "tunnel_dns" {
  zone_id = "${var.cloudflare_zone_id}"
  name    = "${var.name}.${var.cloudflare_zone}"
  value   = "${cloudflare_tunnel.tunnel.id}.cfargotunnel.com"
  type    = "CNAME"
  proxied = true
}