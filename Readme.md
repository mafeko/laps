# laps 📷

This project is motivated by the need of an easy setup for a DSLR-timelaps using existing tools.


![](docs/architecture.drawio.png)

The basic architecture is composed of:

- a client (most likely raspberryPi)
    - running a tailscale client
    - with a connected DSLR camera
    - running [gphoto2](gphoto2.org) for DSLR remote control
    - rsync cron job syncing the photos in batches to the server

- a server (in my case hosted on hetzner.de)
    - running a tailscale client


[Tailscale](https://tailscale.com/) is used because of it's incredible easy setup and high security.


## Setup

### Server
```bash
apt-get update && apt-get install -y rsync

export LAPS_DATA_FOLDER=/mnt/data-volume/timelaps
sudo mkdir -p "$LAPS_DATA_FOLDER"
sudo groupadd rsync
sudo useradd -g rsync rsync
sudo chown rsync:rsync "$LAPS_DATA_FOLDER"

# checkout this repo on the server
cd ~
git clone https://github.com/mafeko/laps.git
sudo cp laps/server/rsyncd.conf /etc/rsyncd.conf

systemctl start rsync.service
systemctl enable rsync.service
```

Test the connection from a client connected via the tailscale vpn:
```bash
rsync -rdt rsync://IPADDR:12000/
```

### Client

## SSH Setup

```bash
ssh-keygen -f ./client.key -t ecdsa -b 521  
ssh-copy-id -i ./client.key user@host
mv client.key ansible/
```