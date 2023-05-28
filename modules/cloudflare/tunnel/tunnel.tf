# The random_id resource is used to generate a 35 character secret for the tunnel
resource "random_id" "tunnel_secret" {
  byte_length = 35
}

# A Named Tunnel resource called zero_trust_ssh_http
resource "cloudflare_tunnel" "auto_tunnel" {
  account_id = "${var.cloudflare_account_id}"
  name       = "${var.name}"
  secret     = random_id.tunnel_secret.b64_std
}

# DNS settings to CNAME to tunnel target for HTTP application
resource "cloudflare_record" "tunnel_dns" {
  zone_id = "${var.cloudflare_zone_id}"
  name    = "${var.name}.${var.cloudflare_zone}"
  value   = "${cloudflare_tunnel.auto_tunnel.id}.cfargotunnel.com"
  type    = "CNAME"
  proxied = true
}