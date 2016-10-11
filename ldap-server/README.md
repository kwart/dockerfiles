# Docker ldap-server image

Alpine Linux Docker image with Apache DS based LDAP server

## Tags

* 2016-10-04

## How to run it

### Default LDIF

```bash
docker run -it --rm -p 10389:10389 kwart/ldap-server 
```
### Custom LDIF

If the LDIF is located in current directory and named `custom.ldif`

```bash
docker run -it --rm \
    -p 10389:10389 \
    -v `pwd`:/mnt \
    kwart/ldap-server \
    java -jar ldap-server.jar /mnt/custom.ldif
```
