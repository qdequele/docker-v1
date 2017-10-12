FROM debian:latest

RUN apt-get upgrade && apt-get update && apt-get install -y git wget golang-go sudo 

RUN adduser --disabled-password --no-create-home --gecos "" qdequele
RUN sudo su

USER root

RUN wget https://dl.gogs.io/0.11.29/linux_amd64.tar.gz 
RUN tar -xvzf linux_amd64.tar.gz


RUN chown -R qdequele:qdequele /gogs
RUN chmod 0770 /root
EXPOSE 22 3000

WORKDIR /gogs

ENTRYPOINT [ "./gogs", "web" ]