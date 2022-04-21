# FROM ubuntu:20.04
# RUN apt update 
# RUN apt install openjdk-11-jdk -y
# RUN apt install maven -y

# EXPOSE 9000

# COPY traffic-violation-kjar app/traffic-violation-kjar
# COPY traffic-violation-model app/traffic-violation-model
# COPY traffic-violation-service app/traffic-violation-service
# # COPY  traffic-violation-service/launch.sh launch.sh


# WORKDIR /app/traffic-violation-service

# RUN chmod 755 /app/traffic-violation-service/launch.sh
# ENTRYPOINT [ "./launch.sh" , "clean" , "install" ]


FROM alpine:latest 

RUN apk update \ 
    && apk add --update openjdk11 \ 
    && apk add --update maven \
    && apk add --no-cache --upgrade bash

EXPOSE 9000

COPY traffic-violation-kjar app/traffic-violation-kjar
COPY traffic-violation-model app/traffic-violation-model
COPY traffic-violation-service app/traffic-violation-service
# COPY  traffic-violation-service/launch.sh launch.sh


WORKDIR /app/traffic-violation-service

RUN chmod 755 /app/traffic-violation-service/launch.sh
ENTRYPOINT [ "./launch.sh" , "clean" , "install" ]