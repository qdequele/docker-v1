FROM debian:latest

RUN apt-get upgrade && apt-get update && apt-get install -y git wget golang-go sudo 

ENV USER="qdequele"

RUN adduser --disabled-password --gecos "" qdequele

USER qdequele
WORKDIR /home/qdequele

RUN wget https://dl.gogs.io/0.11.29/linux_amd64.tar.gz 
RUN tar -xvzf linux_amd64.tar.gz

EXPOSE 22 3000

WORKDIR /home/qdequele/gogs

ENTRYPOINT [ "./gogs", "web" ]