# Simple Mail Forwarder

Systemctl service based on [docker-simple-mail-forwarder](https://github.com/huan/docker-simple-mail-forwarder)

## Installation

```
bash <(curl -s https://raw.githubusercontent.com/joaogsleite/simple-mail-forwarder/master/install.sh)
```


## Configuration

1. Create a `txt` file for each website/project on `/etc/simple-mail-forwarder/mail.d/`

```
sudo vim /etc/simple-mail-forwarder/mail.d/example.txt
```

2. Add one rule per line on that file

```
myname@example.com:myaccount@gmail.com:EXAMPLEPASSWORD
@example.com:myaccount@gmail.com
```

3. Save the file and reload the *simple-mail-forwarder* service

```
sudo systemctl restart simple-mail-forwarder
```

4. DKIM keys will be added to `/etc/simple-mail-forwarder/dkim/`.

> Copy value inside `default.txt` to a DNS TXT record named `default._domainkey`