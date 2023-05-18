# syntax=docker/dockerfile:1
ARG IMAGE=intersystemsdc/iris-community:preview

FROM ${IMAGE}

USER root

WORKDIR /opt/irisbuild

RUN mkdir /opt/irisbuild/data/ && \
  mkdir /opt/irisbuild/src/ && \
  chown ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} /opt/irisbuild && \
  chown ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} /opt/irisbuild/data && \
  chown ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} /opt/irisbuild/src

USER ${ISC_PACKAGE_MGRUSER}

COPY iris.script iris.script
COPY data/guests.gof ./data/guests.gof
COPY data/rooms.csv ./data/rooms.csv
COPY src/cls/Resort/Guests.cls ./src/Guests.cls

EXPOSE 1972

RUN iris start IRIS \
    && iris session IRIS < iris.script \
    && iris stop IRIS quietly

RUN wget --continue -P /opt/irisbuild/data/ https://repo1.maven.org/maven2/com/mysql/mysql-connector-j/8.0.33/mysql-connector-j-8.0.33.jar
