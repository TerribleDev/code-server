#!/usr/bin/env bash

sudo curl -sSL https://dot.net/v1/dotnet-install.sh | sudo bash /dev/stdin -Channel 6.0 -InstallDir /usr/share/dotnet && sudo ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet
git config --global user.email "tommy@terribledev.io"
git config --global user.name "Tommy Parnell"
sudo apt-get install libicu-dev -y && sudo apt-get install build-essential -y
curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null && echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | sudo tee /etc/apt/sources.list.d/ngrok.list
sudo apt update && sudo apt install ngrok
