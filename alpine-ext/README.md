# Docker alpine-ext images

Alpine Linux Docker image with additional stuff included

## Tags

* 1.1-rich (based on alpine:3.6)
* 1.0-rich (based on alpine:3.3)
* 3.3-ssh-sudo
* 3.3-ssh
* 3.2-ssh
* 3.2-bash

### *-bash tags
Alpine Linux with `bash` package installed and configured as CMD.


### *-ssh tags
Alpine Linux with `bash`, `dropbear` and `openssh` packages installed.

The **[dropbear](https://matt.ucc.asn.au/dropbear/dropbear.html)** is a lightweight SSH server and client.

The image uses a new `/docker-entrypoint.sh` script to configure and start the SSH server.

The OpenSSH server is not started in the default configuration. The package is installed mainly to provide `scp` and `sftp-server`
functionality to the `dropbear`.

#### Environment variables
The environment variables can be used to configure SSH server

| Variable      | Default | Description |
| ------------- | ------- |---------|
| SSH_PORT      | 22      | TCP port on which SSH server will be started |
| ROOT_PASSWORD |         | root's password |
| ROOT_AUTHORIZED_KEY |   | entry to be added to /root/.ssh/authorized_keys |

### *-ssh-sudo tags
Similar to *-ssh tags, it adds the `sudo` package and also `alpine` user which has entry in `sudoers` file.

Password for the user  is generated and stored in `/tmp/password.alpine`. The root's password is also stored on filesystem (`/tmp/password.root`) and in case it's not provided by environment variable it's newly generated.

#### Environment variables
The ones included in *-ssh tag plus following

| Variable      | Default | Description |
| ------------- | ------- |---------|
| USER_PASSWORD |         | alpine user's password |
| USER_AUTHORIZED_KEY |   | entry to be added to /home/alpine/.ssh/authorized_keys |

### *-rich tags
Numbering of this tags doesn't copy the alpine numbering! (e.g. `rich-1.0` is based on `alpine:3.3`)

This image adds more features to ones provided by `*-ssh-sudo`. New package(s):
* iptables (from rich-1.0)
* openjdk8 (from rich-1.1)

## Sample usage

Start the container with root's password configured to `"alpine"`.
The dropbear SSH server will run on foreground.

```bash
docker run -e "ROOT_PASSWORD=alpine" -it kwart/alpine-ext:3.3-ssh
```

Start the container with SSH private key authentication configured.
The `dropbear` SSH server will run on background and `bash` on foreground

```bash
docker run -e "ROOT_AUTHORIZED_KEY=`cat ~/.ssh/id_rsa.pub`" -it kwart/alpine-ext:3.3-ssh /bin/bash
```
