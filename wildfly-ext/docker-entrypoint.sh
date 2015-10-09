#!/bin/bash
set -e

if [ "$1" = "standalone" -o "$1" = "domain"  ]; then
  # if the first argument is a WildFly run mode, then prepare the run
  
  WILDFLY_MODE=$1
  WILDFLY_SERVER_CONFIG=${WILDFLY_SERVER_CONFIG:-${WILDFLY_MODE}.xml}
  WILDFLY_BIND_ADDR=${WILDFLY_BIND_ADDR:-0.0.0.0}
  if [ "${WILDFLY_BIND_ADDR}" = "auto" ]; then
    WILDFLY_BIND_ADDR=`java -cp /opt/jboss GetIp`
  fi
  WILDFLY_BIND_ADDR_MGMT=${WILDFLY_BIND_ADDR_MGMT:-${WILDFLY_BIND_ADDR}}
  
  # skip the first argument - the other arguments will be used as additional WildFly parameters
  shift

  echo
  echo "Starting WildFly ${WILDFLY_VERSION}"
  echo "======================================="
  echo "WILDFLY_MODE            ${WILDFLY_MODE}"
  echo "WILDFLY_SERVER_CONFIG   ${WILDFLY_SERVER_CONFIG}"
  echo "WILDFLY_BIND_ADDR       ${WILDFLY_BIND_ADDR}"
  echo "WILDFLY_BIND_ADDR_MGMT  ${WILDFLY_BIND_ADDR_MGMT}"
  echo

  if ! grep -q -e '^admin=' "${JBOSS_HOME}/standalone/configuration/mgmt-users.properties"; then
    if [ -z "${WILDFLY_ADMIN_PASSWORD}" ]; then
      echo "Password for 'admin' account was not provided! Access to Management interface will not be configured." >&2
    else
      echo "WILDFLY_ADMIN_PASSWORD  ****"
      echo
      "${JBOSS_HOME}/bin/add-user.sh" -u admin -p "${WILDFLY_ADMIN_PASSWORD}" -r ManagementRealm -g SuperUser
    fi
  fi

  echo
  echo "-- ${JBOSS_HOME}/bin/${WILDFLY_MODE}.sh -c ${WILDFLY_SERVER_CONFIG} -b ${WILDFLY_BIND_ADDR} -bmanagement ${WILDFLY_BIND_ADDR_MGMT} $@"
  echo
  "${JBOSS_HOME}/bin/${WILDFLY_MODE}.sh" -c ${WILDFLY_SERVER_CONFIG} -b ${WILDFLY_BIND_ADDR} -bmanagement ${WILDFLY_BIND_ADDR_MGMT} $@
else
  # the first argument was not recognized as the WildFly run mode, let's exec the arguments as a command
  exec "$@"
fi
