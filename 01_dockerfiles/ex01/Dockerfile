FROM debian:latest

RUN apt-get upgrade && apt-get update && apt-get install -y bzip2 wget

ENV TS_DIR="/opt/teamspeak"
ENV TS_RELEASE="3.0.13"
ENV TS_NAME="teamspeak3-server_linux_amd64" 
ENV TS_ARCHIVE="${TS_NAME}-${TS_RELEASE}.tar.bz2"

RUN wget http://dl.4players.de/ts/releases/${TS_RELEASE}/${TS_ARCHIVE}
RUN tar jxvf ${TS_ARCHIVE}
RUN mv -f ${TS_NAME} ${TS_DIR}
RUN adduser --disabled-password --no-create-home --gecos "" teamspeak
RUN chown -R teamspeak:teamspeak ${TS_DIR}
RUN chmod 0770 ${TS_DIR}

EXPOSE 9987/udp 30033 10011

USER teamspeak

WORKDIR ${TS_DIR}

ENV PATH="/opt/teamspeak/:$PATH"

ENTRYPOINT ["ts3server_minimal_runscript.sh"]