FROM ubuntu:20.04

# Expose ports to taste
# EXPOSE 80 8000 8080 443 5432 27017

# Make sure we have the necessary command line tools
# as well as some libraries that are mysteriously needed
# in order for OpenJDK to work.
RUN DEBIAN_FRONTEND=noninteractive apt -y update && \
    DEBIAN_FRONTEND=noninteractive apt -y upgrade && \
    DEBIAN_FRONTEND=noninteractive apt -y install python3 python3-pip zlib1g-dev \
                                                  build-essential make pkg-config \
                                                  autoconf automake m4 \
                                                  git curl wget \
                                                  libxext6 libxrender1 libxtst6 libxi6 \
                                                  libfreetype6 fontconfig \
                                                  vim

# We download all the required dependencies here.
RUN mkdir -p /root/utils
WORKDIR /root/utils

# Download and unpack OpenJDK and add it to PATH.
# Also download ÁNYK/ABEVJAVA installer.
RUN curl -o openjdk-10.0.2_linux-x64_bin.tar.gz 'https://download.java.net/java/GA/jdk10/10.0.2/19aef61b38124481863b1413dce1855f/13/openjdk-10.0.2_linux-x64_bin.tar.gz'
RUN curl -o abevjava_install.jar 'https://www.nav.gov.hu/data/cms36637/abevjava_install.jar'
RUN tar -xf openjdk-10.0.2_linux-x64_bin.tar.gz
ENV PATH "$PATH:/root/utils/jdk-10.0.2/bin"

# Create install directory and user data volume.
# (The former makes `abevjava_install.jar` not ask about creating them,
# making the installation process ever so slightly less painful.)
RUN mkdir -p /usr/share/abevjava
VOLUME /root/abevjava

# Copy over convenience installer and runner scripts.
COPY install.sh /root/
COPY abevjava.sh /root/
RUN chmod +x /root/install.sh
RUN chmod +x /root/abevjava.sh

# Set workdir to home on startup
WORKDIR /root

CMD ./install.sh && \
    echo '************* NOTE *************' && \
    echo 'Run `./install.sh` to run the installer again, if needed.' && \
    echo 'Do **NOT** change the default install or user data location.' && \
    echo '' && \
    echo 'Run `./abevjava.sh` in order to start the ÁNYK once installed.' && \
    echo 'Have fun! <3' && \
    echo '********************************' && \
    /bin/bash
