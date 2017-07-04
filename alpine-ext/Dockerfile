#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#  http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.


FROM alpine:3.6

MAINTAINER Josef (kwart) Cacek <josef.cacek@gmail.com>

ENV DROPBEAR_CONF=/etc/dropbear \
    ALPINE_USER=alpine

RUN echo "Installing APK packages" \
    && apk add --update bash dropbear openssh sudo iptables openjdk8 \
    && echo "Configuring SSH" \
    && mkdir /usr/libexec \
    && ln -s /usr/lib/ssh/sftp-server /usr/libexec/ \
    && touch /var/log/lastlog \
    && echo "Adding user $ALPINE_USER in wheel group (with a NOPASSWD: entry in sudoers file)" \
    && adduser -D $ALPINE_USER \
    && adduser $ALPINE_USER wheel \
    && echo '%wheel ALL=(ALL) NOPASSWD: ALL' >/etc/sudoers.d/wheel \
    && echo "Cleaning APK cache" \
    && rm -rf /var/cache/apk/*

COPY docker-entrypoint.sh /

EXPOSE 22

USER alpine

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD []
