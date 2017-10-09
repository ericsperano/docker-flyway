FROM java:openjdk-8-jre-alpine

ENV FLYWAY_VERSION 4.2.0
ENV FLYWAY_SQL_DIR /sql

#&& sed -i 's/bash/sh/' /opt/flyway/flyway \

RUN mkdir /opt \
  && apk update \
  && apk add ca-certificates wget \
  && update-ca-certificates \
  && wget -qO- https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/${FLYWAY_VERSION}/flyway-commandline-${FLYWAY_VERSION}.tar.gz | tar -xzf- -C /opt \
  && mv /opt/flyway-${FLYWAY_VERSION} /opt/flyway \
  && echo "flyway.locations=filesystem:${FLYWAY_SQL_DIR}" > /opt/flyway/conf/flyway.conf \
  && echo "flyway.encoding=UTF-8" >> /opt/flyway/conf/flyway.conf

COPY flyway.sh /opt/flyway/flyway

# Default location for sql migrations
VOLUME /sql

ENTRYPOINT ["/opt/flyway/flyway"]

CMD ["info"]
