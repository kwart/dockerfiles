# Managable WildFly Docker image

This is an example Dockerfile with [WildFly application server](http://wildfly.org/).

## Usage

To boot in standalone mode

    docker run -it kwart/wildfly

To boot in domain mode

    docker run -it kwart/wildfly domain

## Configuration

You can control run of the WildFly through docker run command (`CMD`) and environment variables.

### Run command

There is an additional logic implemented in Docker entrypoint script (`/docker-entrypoint.sh`). It handles environment variables and it does additional configuration steps in case the WildFly run mode is used as first argument in command (CMD). Supported modes are:

* `standalone`
* `domain`

Other command arguments following the run mode are added to the command line.

To run domain mode with Security Manager enabled and multicast address specified

    docker run -it kwart/wildfly domain -secmgr -u 230.0.0.4

Default Docker command for this image is the `"standalone"`.

Commands which doesn't start with one of the modes are executed directly.

To start just a shell

    docker run -it kwart/wildfly /bin/bash

### Environment variables

The `/docker-entrypoint.sh` script controls the WildFly configuration by using following environment variables provided to `docker run` command:

* `WILDFLY_SERVER_CONFIG` server configuration file used  (default: based on WildFly mode one of `"standalone.xml"` / `"domain.xml"`)
* `WILDFLY_BIND_ADDR` bind address. A special value `"auto"` can be used here to automatically use one IP address - i.e. not bind to all interfaces (default: `"0.0.0.0"`)
* `WILDFLY_BIND_ADDR_MGMT` bind address for management interface (default: `"${WILDFLY_BIND_ADDR}"`)
* `WILDFLY_ADMIN_PASSWORD` password for management user `admin`, which is created in case the password is provided (default: `""`)

To run the image with `standalone-full-ha.xml` profile and the `admin` management account ready, let the entrypoint choose the bind address automatically.

    docker run -it \
        -e WILDFLY_BIND_ADDR=auto \
        -e WILDFLY_SERVER_CONFIG=standalone-full-ha.xml \
        -e WILDFLY_ADMIN_PASSWORD=pass.1234 \
        jboss/wildfly

The console output then starts with something like

    Starting WildFly 9.0.1.Final
    =======================================
    WILDFLY_MODE            standalone
    WILDFLY_SERVER_CONFIG   standalone-full-ha.xml
    WILDFLY_BIND_ADDR       172.17.0.14
    WILDFLY_BIND_ADDR_MGMT  172.17.0.14

    WILDFLY_ADMIN_PASSWORD  ****

    Added user 'admin' to file '/opt/jboss/wildfly/standalone/configuration/mgmt-users.properties'
    Added user 'admin' to file '/opt/jboss/wildfly/domain/configuration/mgmt-users.properties'
    Added user 'admin' with groups SuperUser to file '/opt/jboss/wildfly/standalone/configuration/mgmt-groups.properties'
    Added user 'admin' with groups SuperUser to file '/opt/jboss/wildfly/domain/configuration/mgmt-groups.properties'

    -- /opt/jboss/wildfly/bin/standalone.sh -c standalone-full-ha.xml -b 172.17.0.14 -bmanagement 172.17.0.14

Then you can reach the management console on the reported IP address (e.g. `http://172.17.0.14:9990/`) and use `admin`/`pass.1234` credentials to log into it.

## Image internals [updated Sep 10, 2015]

This image extends the [`jboss/wildfly`](https://github.com/jboss-dockerfiles/wildfly/) image and adds some basic configuration.

## Source

The source is [available on GitHub](https://github.com/kwart/dockerfile-wildfly).

## Issues

Please report any issues or file RFEs on [GitHub](https://github.com/kwart/dockerfile-wildfly/issues).

