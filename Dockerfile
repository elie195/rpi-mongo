FROM balenalib/raspberrypi3-64-ubuntu:bionic

ENV MONGO_VERSION 4.2

RUN install_packages wget gnupg
RUN wget -qO - https://www.mongodb.org/static/pgp/server-${MONGO_VERSION}.asc | apt-key add -
RUN echo "deb http://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/${MONGO_VERSION} multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.2.list
RUN install_packages mongodb-org
#RUN apt-get update && apt-get install mongodb-org

RUN mkdir -p /data/db /data/configdb \
        && chown -R mongodb:mongodb /data/db /data/configdb
VOLUME /data/db /data/configdb

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 27017
CMD ["mongod"]
