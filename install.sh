sudo cp simple-mail-forwarder /usr/bin/simple-mail-forwarder
sudo chmod +x /usr/bin/simple-mail-forwarder
sudo cp simple-mail-forwarder.service /etc/systemd/system/simple-mail-forwarder.service
sudo systemctl daemon-reload
sudo systemctl start simple-mail-forwarder
sudo systemctl enable simple-mail-forwarder