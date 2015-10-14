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
#
#
# This Dockerfile creates image based on official alpine linux docker image. 
# It adds bash to the image and sets it as a default command.
#
#
# Expected usage:
# ===============
# docker pull kwart/alpine-ext:3.2-ssh
# docker run -it --rm kwart/alpine-ext:3.2-ssh

FROM alpine:3.2

MAINTAINER Josef (kwart) Cacek <josef.cacek@gmail.com>

RUN apk add --update bash dropbear openssh \
    && mkdir /usr/libexec \
    && ln -s /usr/lib/ssh/sftp-server /usr/libexec/ \
    && rm -rf /var/cache/apk/*

ENV DROPBEAR_CONF=/etc/dropbear

COPY docker-entrypoint.sh /

EXPOSE 22

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD []
