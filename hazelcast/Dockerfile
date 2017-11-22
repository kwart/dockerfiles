FROM openjdk:8-jre

ENV HZ_VERSION=3.9 \
    HZ_HOME=/opt/hazelcast \
    JAVA_OPTS="-Djava.awt.headless=true -Dhazelcast.shutdownhook.policy=GRACEFUL"

RUN mkdir -p $HZ_HOME \
    && apt-get update \
    && apt-get install -y groovy vim \
    && sed -i 's/^assistive_technologies=/#&/' /etc/java-8-openjdk/accessibility.properties

WORKDIR $HZ_HOME

ADD https://repo.maven.apache.org/maven2/com/hazelcast/hazelcast-all/${HZ_VERSION}/hazelcast-all-${HZ_VERSION}.jar hazelcast.xml $HZ_HOME/
COPY bashrc /root/.bashrc

CMD ["/bin/bash"]
