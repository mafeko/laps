# laps 📷

This project is motivated by the need of an easy setup for a DSLR-timelaps using existing tools.

I'm using [Tailscale](https://tailscale.com/) (because of it's incredible easy setup) to keep the communication secure.
Of course you set up `laps` without a vpn in place, but it is not recommended cause:

- vpn adds an additional layer of security around all networking (including the setup via ansible)

![](docs/architecture.drawio.png)

The architecture is composed of:

- a **client** (in my case a raspberryPi)
  - running a tailscale client
  - with a connected DSLR camera
  - running [gphoto2](gphoto2.org) for DSLR remote control
  - running an rclone cron job: uploading the photos to my nextcloud (via webDAV)

- a **server** (in my case hosted on hetzner.de)
  - hosting a nextcloud instance (not part of this repository)
  

## Setup

> As mentioned above I rely on an already set up network connection via [Tailscale](https://tailscale.com/) VPN.

As a prerequisite you need:

- [docker](https://docs.docker.com/get-docker/)
- [task](taskfile.dev)

installed on your local machine.

The central place of configuration lives in [ansible/inventory.yml](ansible/inventory.yml).
This file is the single source of thruth and all other files are populated with values from [ansible/inventory.yml](ansible/inventory.yml) during provisioning.

The only mandatory configuration you have to make is the client's and server's IP adress for ansible to connect to:
```yml
all:
  hosts:
  children:
    client:
      hosts:
        100.95.134.119: # client's IP address (within the tailscale vpn)
```

For the `rclone` role the server-credentials are expected in a [gitignored] text file:
**./secrets**
```
LAPS_RCLONE_URL="https://your-nextcloud-server/remote.php/dav/files/<user>/"
LAPS_RCLONE_USER="user"
LAPS_RCLONE_PASS="base64 encoded password"
```

To provision the client run:

```bash
task client
```

For monitoring the client, I use prometheus installing node_exporter with some custom extensions (e.g. monitoring the number of pictures on the device):

```bash
task metrics
```


### TODO

- [x] (use ansible instead of scripts)
- [x] (introduce lockfile for rclone cron job, preventing parallel upload processes)

### MISC

**SSH setup**

```bash
ssh-keygen -f ./client.key -t ecdsa -b 521  
ssh-copy-id -i ./client.key user@host
mv client.key ansible/
```

**Tailscale Logging**

For practical reasons I completely turned off the tailscale logs in the service:
```
# /usr/lib/systemd/system/tailscaled.service

[Service]
StandardOutput=null
StandardError=null
```