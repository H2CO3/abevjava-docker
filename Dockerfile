FROM debian:12.5-slim

# Make sure we have the necessary command line tools
# as well as some libraries that are mysteriously needed
# in order for OpenJDK to work.
ARG DEBIAN_FRONTEND=noninteractive
RUN apt -y update
RUN apt -y upgrade
RUN apt -y install zlib1g-dev \
    build-essential make pkg-config \
    autoconf automake m4 \
    curl wget \
    libxext6 libxrender1 libxtst6 libxi6 \
    libfreetype6 fontconfig

# We download all the required dependencies here.
RUN mkdir -p /root/utils
WORKDIR /root/utils

# Unpack OpenJDK runtime for correct CPU architecture and add it to PATH.
# Delete the archive files to save space in the Docker image
COPY jre jre
ARG TARGETARCH
RUN mkdir -p OpenJDK8U
RUN \
    if [ $TARGETARCH = "arm64" -o $TARGETARCH = "aarch64" ]; then \
        JDKARCH='aarch64'; \
    elif [ $TARGETARCH = "arm" -o $TARGETARCH = "armhf" -o $TARGETARCH = "armel" ]; then \
        JDKARCH='arm'; \
    else \
        JDKARCH='x64'; \
    fi; \
    tar -C OpenJDK8U --strip-components=1 -xf "jre/OpenJDK8U-jre_${JDKARCH}_linux_hotspot_8u402b06.tar.gz"
RUN rm -rf jre
ENV PATH "$PATH:/root/utils/OpenJDK8U/bin"

# Copy over the ÁNYK/ABEVJAVA installer and form/document plug-in installers.
COPY jars jars

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

# Fix Quartz on macOS on Apple Silicon (M1/M2/M3)
ENV _JAVA_OPTIONS="-Dsun.java2d.xrender=false"

# Expose ports to taste
# EXPOSE 80 8000 8080 443 5432 27017

CMD ./install.sh && \
    echo '************* NOTE *************' && \
    echo 'Run `./install.sh` to run the installer again, if needed.' && \
    echo 'Do **NOT** change the default install or user data location.' && \
    echo '' && \
    echo 'ÁNYK starts automatically after installation.' && \
    echo 'Run `./abevjava.sh` to restart it.' && \
    echo 'Have fun! <3' && \
    echo '********************************' && \
    /root/abevjava.sh
