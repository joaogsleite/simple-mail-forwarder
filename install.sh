#!/usr/bin/env bash

BASE_URL="https://raw.githubusercontent.com/joaogsleite/simple-mail-forwarder/master/"

sudo apt update -y

# docker
sudo apt install -y docker.io
sudo systemctl enable docker

# wget
sudo apt install -y wget

# docker-compose
sudo apt install -y jq
VERSION=$(curl --silent https://api.github.com/repos/docker/compose/releases/latest | jq .name -r)
OS=$(uname -s)
ARCH=$(uname -m)
sudo curl -L "https://github.com/docker/compose/releases/download/$VERSION/docker-compose-$OS-$ARCH" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# simple-mail-forwarder script
sudo wget -O /usr/bin/simple-mail-forwarder $BASE_URL/simple-mail-forwarder
sudo chmod +x /usr/bin/simple-mail-forwarder

# simple-mail-forwader configs
sudo mkdir -p /etc/simple-mail-forwarder/mail.d/
if [ -z "$(ls -A /etc/simple-mail-forwarder/mail.d/)" ]; then 
  echo "@example.com:exampleaccount@gmail.com" > /etc/simple-mail-forwarder/mail.d/example.txt
fi
if [ ! -f /etc/simple-mail-forwarder/domain.txt ] then
  echo "example.com" > /etc/simple-mail-forwarder/domain.txt
fi

# simple-mail-forwarder service
sudo wget -O /etc/systemd/system/simple-mail-forwarder.service $BASE_URL/simple-mail-forwarder.service
sudo systemctl daemon-reload
sudo systemctl stop simple-mail-forwarder
sudo systemctl start simple-mail-forwarder
sudo systemctl enable simple-mail-forwarder

