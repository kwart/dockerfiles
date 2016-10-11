FROM alpine:3.4

MAINTAINER Josef (kwart) Cacek <josef.cacek@gmail.com>

RUN echo "Installing APK packages" \
    && apk add --update bash openjdk8 openssl \
    && echo "Retrieving ldap-server.war" \
    && wget -O /ldap-server.jar https://github.com/kwart/ldap-server/releases/download/2016-10-04/ldap-server.jar \
    && echo "Cleaning APK cache" \
    && rm -rf /var/cache/apk/*

EXPOSE 10389

CMD ["java", "-jar", "/ldap-server.jar"]
