#!/bin/bash
set -e

SSH_PORT=${SSH_PORT:-22}

echo
echo "Starting alpine linux with dropbear SSH server"
echo "=============================================="
echo "SSH_PORT                ${SSH_PORT}"
echo "ROOT_PASSWORD           ${ROOT_PASSWORD:+*****}" 
echo "ROOT_AUTHORIZED_KEY     ${ROOT_AUTHORIZED_KEY:+${ROOT_AUTHORIZED_KEY:0:20}}" 

if [ ! -d "${DROPBEAR_CONF}" ]; then
    echo
    echo "Configuring dropbear SSH server in folder ${DROPBEAR_CONF}" 
    
    mkdir -p "${DROPBEAR_CONF}"
    dropbearkey -t dss -f "${DROPBEAR_CONF}/dropbear_dss_host_key"
    dropbearkey -t rsa -f "${DROPBEAR_CONF}/dropbear_rsa_host_key" -s 2048
    dropbearkey -t ecdsa -f "${DROPBEAR_CONF}/dropbear_ecdsa_host_key"

    # set root password if needed
    if [ -n "$ROOT_PASSWORD" ]; then
        echo
        echo "Changing root's password" 
        echo "root:$ROOT_PASSWORD" | chpasswd
    fi;

    # set root's authorized_keys
    if [ -n "$ROOT_AUTHORIZED_KEY" ]; then
        echo
        echo "Adding entry to /root/.ssh/authorized_keys" 
        mkdir -p /root/.ssh
        echo "$ROOT_AUTHORIZED_KEY" >> /root/.ssh/authorized_keys
    fi;
fi

echo

if [ $# -gt 0 ]; then
    echo "Running dropbear SSH server on background"
    echo "dropbear -p ${SSH_PORT}"
    dropbear -p ${SSH_PORT}

    echo
    echo "Executing command $@"
    exec "$@"
else
    echo "Running dropbear SSH server on foreground"
    echo "dropbear -p ${SSH_PORT} -E -F"
    dropbear -p ${SSH_PORT} -E -F
fi
