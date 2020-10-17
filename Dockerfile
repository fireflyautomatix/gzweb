# Download base image 
FROM gazebo:libgazebo9

RUN mkdir /root/gzweb
WORKDIR /root/gzweb

# HACK, replacing shell with bash for later docker build commands
RUN mv /bin/sh /bin/sh-old && \
    ln -s /bin/bash /bin/sh

# install packages
RUN apt-get update && apt-get upgrade -q -y && apt-get install -q -y \
    build-essential \
    cmake \
    imagemagick \
    libboost-all-dev \
    libgts-dev \
    libjansson-dev \
    libtinyxml-dev \
    mercurial \
    git \
    nodejs \
    nodejs-dev \
    node-gyp \
    libssl1.0-dev 
    #nodejs-legacy \
    #npm \
RUN apt-get install -q -y \
    curl \
    pkg-config \
    psmisc \
    libignition-math4-dev \
    libignition-gazebo \
    libgazebo9-dev \
    && rm -rf /var/lib/apt/lists/*
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN curl -sL https://npmjs.org/install.sh | sh
ENTRYPOINT ["/gzserver_entrypoint.sh"]
RUN apt-get update -q -y && apt-get upgrade -q -y
#get source
COPY . .
RUN npm run deploy ---
