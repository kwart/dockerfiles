# Tools in Docker

Helper tools for my projects... I'm too lazy to install every piece of SW on all my computers.

Usually, I put following lines to `~/.bash_aliases`

```bash
alias travis='docker run -it --rm -v $PWD:/repo -v ~/.travis:/root/.travis kwart/tools /usr/bin/travis'
alias docker-scripts='docker run --rm -v $PWD:/repo -v /var/run/docker.sock:/var/run/docker.sock /usr/bin/docker-scripts kwart/tools'
```

## Travis CLI

Inspired by versions from [André Dumas](https://github.com/andredumas/docker-travis-ci-cli)
and [James Pamplin](https://github.com/jamespamplin/docker-alpine-travis-cli).


The image contains [travis ci client](http://blog.travis-ci.com/2013-01-14-new-client/) - following 
[installation instructions](https://github.com/travis-ci/travis.rb#installation).

Primarily used to `travis setup releases`

### Sample Usage - Configure GitHub Releases

```bash
# Create a simple alias to run the in-docker travis client
alias travis='docker run -it --rm -v $PWD:/repo -v ~/.travis:/root/.travis kwart/tools /usr/bin/travis'

# Create Travis configuration file
cat << EOT >.travis.yml
language: java
jdk: oraclejdk8
EOT

# Setup GitHub releases
travis setup releases

# ...
# Follow on screen instructions - login with GitHub username and password and specify which files to release
# If something goes wrong check the directory ~/.travis on the host
```

## Marek Goldmann's docker-scripts

Squashing docker images made easy. The [docker-scripts](https://github.com/goldmann/docker-scripts) from Marek Goldman.

### Usage

```
$ alias docker-scripts='docker run --rm -v $PWD:/repo -v /var/run/docker.sock:/var/run/docker.sock /usr/bin/docker-scripts kwart/tools'
$ docker-scripts -c jboss/wildfly:latest
511136ea3c5a64f264b78b5433614aec563103b4d4702f3ba7d4d2698e22c158
 └─ 782cf93a8f16d3016dae352188cd5cfedb6a15c37d4dbd704399f02d1bb89dab [/bin/sh -c #(nop) MAINTAINER Lokesh Mandvekar <lsm5@fedoraproject.org> - ./buildcontainers.sh]
  └─ 7d3f07f8de5fb3a20c6cb1e4447773a5741e3641c1aa093366eaa0fc690c6417 [/bin/sh -c #(nop) ADD file:285fdeab65d637727f6b79392a309135494d2e6046c6cc2fbd2f23e43eaac69c in /]
   └─ 1ef0a50fe8b1394d3626a7624a58b58cff9560ddb503743099a56bbe95ab481a [/bin/sh -c #(nop) MAINTAINER Marek Goldmann <mgoldman@redhat.com>]
    └─ 20a1abe1d9bfb9b1e46d5411abd5a38b6104a323b7c4fb5c0f1f161b8f7278c2 [/bin/sh -c yum -y update && yum clean all]
     └─ cd5bb934bb6755e910d19ac3ae4cfd09221aa2f98c3fbb51a7486991364dc1ae [/bin/sh -c yum -y install xmlstarlet saxon augeas bsdtar unzip && yum clean all]
      └─ 379edb00ab0764276787ea777243990da697f2f93acb5d9166ff73ad01511a87 [/bin/sh -c groupadd -r jboss -g 1000 && useradd -u 1000 -r -g jboss -m -d /opt/jboss -s /sbin/nologin -c "JBoss user" jboss]
       └─ 4d37cbbfc67dd508e682a5431a99d8c1feba1bd8352ffd3ea794463d9cfa81cc [/bin/sh -c #(nop) WORKDIR /opt/jboss]
        └─ 2ea8562cac7c25a308b4565b66d4f7e11a1d2137a599ef2b32ed23c78f0a0378 [/bin/sh -c #(nop) USER jboss]
         └─ 7759146eab1a3aa5ba5ed12483d03e64a6bf1061a383d5713a5e21fc40554457 [/bin/sh -c #(nop) MAINTAINER Marek Goldmann <mgoldman@redhat.com>]
          └─ b17a20d6f5f8e7ed0a1dba277acd3f854c531b0476b03d63a8f0df4caf78c763 [/bin/sh -c #(nop) USER root]
           └─ e02bdb6c4ed5436da02c958d302af5f06c1ebb1821791f60d45e190ebb55130f [/bin/sh -c yum -y install java-1.7.0-openjdk-devel && yum clean all]
            └─ 72d585299bb5c5c1c326422cfffadc93d8bb4020f35bf072b2d91d287967807a [/bin/sh -c #(nop) USER jboss]
             └─ 90832e1f0bb9e9f98ecd42f6df6b124c1e6768babaddc23d646cd75c7b2fddec [/bin/sh -c #(nop) ENV JAVA_HOME=/usr/lib/jvm/java]
              └─ b2b7d0c353b9b7500d23d2670c99abf35c4285a5f396df7ef70386848b45d162 [/bin/sh -c #(nop) ENV WILDFLY_VERSION=8.2.0.Final]
               └─ 3759d5cffae63d6ddc9f2db9142403ad39bd54e305bb5060ae860aac9b9dec1d [/bin/sh -c cd $HOME && curl http://download.jboss.org/wildfly/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.tar.gz | tar zx && mv $HOME/wildfly-$WILDFLY_VERSION $HOME/wildfly]
                └─ 5c98b1e90cdcdb322601091f1f8654bc551015caa9ec41da040ef9a1d8466839 [/bin/sh -c #(nop) ENV JBOSS_HOME=/opt/jboss/wildfly]
                 └─ 8ac46a315e1ef48cfbe30e9d15242f8f73b322e8ede54c30d93f6859708d48f7 [/bin/sh -c #(nop) EXPOSE 8080/tcp]
                  └─ 2ac466861ca121d4c5e17970f4939cc3df3755a7fd90a6d11542b7432c03e215 [/bin/sh -c #(nop) CMD [/opt/jboss/wildfly/bin/standalone.sh -b 0.0.0.0]]

$ docker-scripts squash jboss/wildfly -f jboss/base:latest -t jboss/wildfly:squashed
2015-05-11 10:23:35,602 root         INFO     Squashing image 'jboss/wildfly'...
2015-05-11 10:23:35,857 root         INFO     Old image has 19 layers
...
$ docker-scripts layers -t jboss/wildfly:squashed
511136ea3c5a64f264b78b5433614aec563103b4d4702f3ba7d4d2698e22c158
 └─ 782cf93a8f16d3016dae352188cd5cfedb6a15c37d4dbd704399f02d1bb89dab
  └─ 7d3f07f8de5fb3a20c6cb1e4447773a5741e3641c1aa093366eaa0fc690c6417
   └─ 1ef0a50fe8b1394d3626a7624a58b58cff9560ddb503743099a56bbe95ab481a
    └─ 20a1abe1d9bfb9b1e46d5411abd5a38b6104a323b7c4fb5c0f1f161b8f7278c2
     └─ cd5bb934bb6755e910d19ac3ae4cfd09221aa2f98c3fbb51a7486991364dc1ae
      └─ 379edb00ab0764276787ea777243990da697f2f93acb5d9166ff73ad01511a87
       └─ 4d37cbbfc67dd508e682a5431a99d8c1feba1bd8352ffd3ea794463d9cfa81cc
        └─ 2ea8562cac7c25a308b4565b66d4f7e11a1d2137a599ef2b32ed23c78f0a0378 [u'docker.io/jboss/base:latest']
         └─ b7e845026f73f67ebeb59ed1958d021aa79c069145d66b1233b7e9ba9fffa729 [u'jboss/wildfly:squashed']
```
