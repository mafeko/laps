# Laps

This project is motivated by the need of an easy setup of a timelaps with existing tools.

The basic architecture is composed of:

- a server (in my case hosted on hetzner.de)
    - running a tailscale client
- a client (most likely raspberryPi)
    - running a tailscale client
    - wit a connected DSLR camera

[Tailscale](https://tailscale.com/) is used because of it's incredible easy setup and high security.
