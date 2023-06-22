FROM debian:11.6

COPY ./entrypoint.sh /tmp

RUN apt-get update && \
apt-get upgrade && \
apt-get install -y openjdk-17-jdk ca-certificates wget && \
mkdir /data && \
useradd -d /data minecraft && \
mv /tmp/entrypoint.sh  / && \
chmod +x /entrypoint.sh && \
chown -R  minecraft:minecraft /data/ && \
wget https://piston-data.mojang.com/v1/objects/84194a2f286ef7c14ed7ce0090dba59902951553/server.jar -P /tmp && \
chown minecraft:minecraft /tmp/server.jar

WORKDIR /data
VOLUME /data

USER minecraft

EXPOSE 25565/tcp
EXPOSE 25565/tcp

ENV MEM_JAV=1024

ENTRYPOINT ["/entrypoint.sh"]
