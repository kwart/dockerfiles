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
# docker pull kwart/alpine-ext:3.2-bash
# docker run -it --rm kwart/alpine-ext:3.2-bash

FROM alpine:3.2

MAINTAINER Josef Cacek <josef.cacek@gmail.com>

RUN apk add --update bash \
    && rm -rf /var/cache/apk/*

CMD ["/bin/bash"]
