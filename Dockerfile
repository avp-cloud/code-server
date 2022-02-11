# Base image, greatful to linuxserver
FROM ghcr.io/linuxserver/code-server:v4.0.2-ls111

# Install python3
RUN apt update && apt install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev wget python3 -y

# Install golang
RUN curl -LO https://dl.google.com/go/go1.17.linux-amd64.tar.gz && tar -xvf go1.17.linux-amd64.tar.gz && mv go /usr/local
ENV GOPATH=$HOME/src
ENV PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

# Install kubectl and helm
RUN curl -LO https://dl.k8s.io/release/v1.22.0/bin/linux/amd64/kubectl && install -m 0755 kubectl /usr/local/bin/kubectl
RUN curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

# Install okteto-cli
RUN curl https://get.okteto.com -sSfL | bash

# Cleanup
RUN  apt-get clean && \
  rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/*

