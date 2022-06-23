#!/bin/sh

# install code-server service system-wide
export HOME=/root
curl -fsSL https://code-server.dev/install.sh | sh

# add our helper server to redirect to the proper URL for --link
git clone https://github.com/bpmct/coder-cloud-redirect-server
cd coder-cloud-redirect-server
cp coder-cloud-redirect.service /etc/systemd/system/
cp coder-cloud-redirect.py /usr/bin/

# create a code-server user
adduser --disabled-password --gecos "" coder
echo "coder ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/coder
usermod -aG sudo coder

# copy ssh keys from root
cp -r /root/.ssh /home/coder/.ssh
chown -R coder:coder /home/coder/.ssh

# configure code-server to use --link with the "coder" user
mkdir -p /home/coder/.config/code-server
touch /home/coder/.config/code-server/config.yaml
echo "link: true" > /home/coder/.config/code-server/config.yaml
chown -R coder:coder /home/coder/.config

# start and enable code-server and our helper service
systemctl enable --now code-server@coder
systemctl enable --now coder-cloud-redirect
sudo curl -sSL https://dot.net/v1/dotnet-install.sh | sudo bash /dev/stdin -Channel 6.0 -InstallDir /usr/share/dotnet && sudo ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet
git config --global user.email "tommy@terribledev.io"
git config --global user.name "Tommy Parnell"
sudo apt-get install libicu-dev -y && sudo apt-get install build-essential -y
curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null && echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | sudo tee /etc/apt/sources.list.d/ngrok.list
sudo apt update && sudo apt install ngrok
sudo apt install -y debian-keyring debian-archive-keyring apt-transport-https
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo apt-key add -
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list
sudo apt update
sudo apt install caddy
sudo echo "${dns_name} \
reverse_proxy 127.0.0.1:8080" > /etc/caddy/Caddyfile
sudo systemctl reload caddy