# Docker alpine-ext images

Alpine Linux Docker image with additional stuff included

## Tags

### 3.2-bash
Alpine Linux `3.2` with `bash` package installed and configured as CMD.


### 3.2-ssh
Alpine Linux `3.2` with `bash` and `dropbear` packages installed.

The **[dropbear](https://matt.ucc.asn.au/dropbear/dropbear.html)** is a lightweight SSH server and client.

The image uses a new `/docker-entrypoint.sh` script to configure and start the SSH server.

#### Environment variables
The environment variables can be used to configure SSH server

| Variable      | Default | Description |
| ------------- | ------- |---------|
| SSH_PORT      | 22      | TCP port on which SSH server will be started |
| ROOT_PASSWORD |         | root's password |
| ROOT_AUTHORIZED_KEY |   | entry to be added to /root/.ssh/authorized_keys |

#### Sampe usage

Start the container with root's password configured to `"alpine"`.
The dropbear SSH server will run on foreground.

```bash
docker run -e "ROOT_PASSWORD=alpine" -it kwart/alpine-ext:3.2-ssh
```

Start the container with SSH private key authentication configured.
The `dropbear` SSH server will run on background and `bash` on foreground

```bash
docker run -e "ROOT_AUTHORIZED_KEY=`cat ~/.ssh/id_rsa.pub`" -it kwart/alpine-ext:3.2-ssh /bin/bash
```
