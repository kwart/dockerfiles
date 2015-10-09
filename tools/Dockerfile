# Tools in docker
#
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

FROM ubuntu:14.04
MAINTAINER Josef Cacek

RUN apt-get update \
    && apt-get -y install ruby1.9.3 build-essential git python-pip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/ \
    && gem install travis --no-rdoc --no-ri \
    && pip install docker-scripts

# Location where travis config stored
ENV TRAVIS_CONFIG_PATH /travis
VOLUME /travis

# Generally the current working dir will be used as the repo volume
VOLUME /repo
WORKDIR /repo

ENTRYPOINT ["/usr/local/bin/travis"]
