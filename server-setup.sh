#!/bin/sh
# Automate server setup.

sudo apt update
sudo apt upgrade -y

# Install docker
sudo apt-get install ca-certificates curl gnupg

sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

# Setup and run our containers.
mkdir /root/docker
cd /root/docker
touch compose.yaml

cat > compose.yaml << EOF
services:
    server:
        image: kennethreitz/httpbin
        container_name: server
        ports:
            - 80:80
    
    cloudflared:
        image: cloudflare/cloudflared:latest 
        container_name: cloudflared
        depends_on:
            - server
        command: tunnel --no-autoupdate --token ${cloudflare_tunnel_token}

EOF

docker compose up -d
