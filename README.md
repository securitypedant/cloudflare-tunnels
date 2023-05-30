# Building multiple cloud virtual machines with an accompanying Cloudflare tunnel

This example Terraform repo shows how you can build many cloud servers (Google in this example) to host a docker based service, and then use a Cloudflare tunnel to secure access to that service.

## How it works
- There are two modules, cloudflare/tunnel and gcp.
 - gcp handles the creation of a virtual machine to host docker, a simple service (httpbin) and the cloudflared software
 - cloudflare/tunnel handles the resources to create a cloudflare tunnel, this module returns a token to be sent to the cloudflared docker.
- The root module has a variable which contains, in the example, the names of two services. This variable is enumerated via for_each to then create both a gcp server and a cloudflared tunnel.

## To try it out.
- Get a free Google Cloud account that will come with some free credit. Create a service account and download the json credentials.
- Create a free Cloudflare account, that allows you to create free tunnels.
 - Go to your profile and copy the "Global API Key" value, combine it with your email into the terraform.tfvars
 - Copy the Zone and Account ID from whatever domain you add to Cloudflare
- Terraform plan and apply to launch the services