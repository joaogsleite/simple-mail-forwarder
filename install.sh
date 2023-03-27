#!/usr/bin/env bash

BASE_URL="https://raw.githubusercontent.com/joaogsleite/simple-mail-forwarder/master/"

# docker
if ! command -v docker &> /dev/null ; then
  curl -fsSL https://get.docker.com -o get-docker.sh
  sudo sh get-docker.sh
  rm get-docker.sh
fi

# simple-mail-forwarder script
sudo curl -L -o /usr/bin/simple-mail-forwarder $BASE_URL/simple-mail-forwarder
sudo chmod +x /usr/bin/simple-mail-forwarder

# simple-mail-forwader configs
sudo mkdir -p /etc/simple-mail-forwarder/mail.d/
if [ -z "$(ls -A /etc/simple-mail-forwarder/mail.d/)" ]; then 
  echo "@example.com:exampleaccount@gmail.com" > /etc/simple-mail-forwarder/mail.d/example.txt
fi
if [ ! -f /etc/simple-mail-forwarder/domain.txt ]; then
  echo "example.com" > /etc/simple-mail-forwarder/domain.txt
fi

# simple-mail-forwarder service
sudo curl -L -o /etc/systemd/system/simple-mail-forwarder.service $BASE_URL/simple-mail-forwarder.service
sudo systemctl daemon-reload
sudo systemctl stop simple-mail-forwarder
sudo systemctl start simple-mail-forwarder
sudo systemctl enable simple-mail-forwarder

