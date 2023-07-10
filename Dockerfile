FROM debian:bullseye-slim
#FROM ubuntu:focal

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y unzip wget && \
    apt-get clean

RUN export VERSION=$( wget https://www.synology.com/en-us/releaseNote/ActiveBackupBusinessAgent -q -O - | grep -Pom 1 'data-version="\K[^"]*' | head -1 ) && \
    wget https://global.download.synology.com/download/Utility/ActiveBackupBusinessAgent/$VERSION/Linux/x86_64/Synology%20Active%20Backup%20for%20Business%20Agent-$VERSION-x64-deb.zip -O /tmp/ActiveBackupBusinessAgent.zip && \
    unzip /tmp/ActiveBackupBusinessAgent.zip -d /tmp/ActiveBackupBusinessAgent

RUN /tmp/ActiveBackupBusinessAgent/install.run

CMD ["redis-server", "--protected-mode no"]
