#!/bin/bash
set -e

changePassword() {
    local PWUSER=$1
    local PWPASS=$2
    local PWFILE="/tmp/password.$PWUSER"
    echo
    if [ -z "$PWPASS" ]; then
        echo "Generating $PWUSER's password"
        PWPASS=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 12 | head -n 1)
    fi;
    echo "Storing $PWUSER's password into $PWFILE"
    echo "$PWPASS" > "$PWFILE"
    sudo chown "$PWUSER:$PWUSER" "$PWFILE"
    sudo chmod 600 $PWFILE
    echo "Changing $PWUSER's password"
    echo "$PWUSER:$PWPASS" | sudo chpasswd
}

SSH_PORT=${SSH_PORT:-22}

echo
echo "Starting alpine linux with dropbear SSH server"
echo "=============================================="
echo "SSH_PORT                ${SSH_PORT}"
echo
echo "User 'root' config"
echo "ROOT_PASSWORD           ${ROOT_PASSWORD:+*****}"
echo "ROOT_AUTHORIZED_KEY     ${ROOT_AUTHORIZED_KEY:+${ROOT_AUTHORIZED_KEY:0:20}}"
echo
echo "User '$ALPINE_USER' config"
echo "USER_PASSWORD           ${USER_PASSWORD:+*****}"
echo "USER_AUTHORIZED_KEY     ${USER_AUTHORIZED_KEY:+${USER_AUTHORIZED_KEY:0:20}}"

if [ ! -d "${DROPBEAR_CONF}" ]; then
    echo
    echo "Configuring dropbear SSH server in folder ${DROPBEAR_CONF}" 
    
    sudo mkdir -p "${DROPBEAR_CONF}"
    sudo dropbearkey -t dss -f "${DROPBEAR_CONF}/dropbear_dss_host_key"
    sudo dropbearkey -t rsa -f "${DROPBEAR_CONF}/dropbear_rsa_host_key" -s 2048
    sudo dropbearkey -t ecdsa -f "${DROPBEAR_CONF}/dropbear_ecdsa_host_key"

    changePassword root $ROOT_PASSWORD
    changePassword $ALPINE_USER $USER_PASSWORD

    # set root's authorized_keys
    if [ -n "$ROOT_AUTHORIZED_KEY" ]; then
        echo
        echo "Adding entry to /root/.ssh/authorized_keys"
        sudo mkdir -p /root/.ssh
        sudo -E sh -c 'echo "$ROOT_AUTHORIZED_KEY" | tee /root/.ssh/authorized_keys'
    fi

    # set user's authorized_keys
    if [ -n "$USER_AUTHORIZED_KEY" ]; then
        echo
        echo "Adding entry to /home/$ALPINE_USER/.ssh/authorized_keys"
        mkdir -p /home/$ALPINE_USER/.ssh
        echo "$USER_AUTHORIZED_KEY" | tee /home/$ALPINE_USER/.ssh/authorized_keys
    fi
fi

echo

if [ $# -gt 0 ]; then
    echo "Running dropbear SSH server on background"
    echo "dropbear -m -p ${SSH_PORT}"
    sudo dropbear -m -p ${SSH_PORT}

    echo
    echo "Executing command $@"
    exec "$@"
else
    echo "Running dropbear SSH server on foreground"
    echo "dropbear -m -p ${SSH_PORT} -E -F"
    sudo dropbear -m -p ${SSH_PORT} -E -F
fi
