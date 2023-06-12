# Base image, greatful to linuxserver
FROM ghcr.io/linuxserver/code-server:4.13.0

# Install golang
RUN curl -LO https://dl.google.com/go/go1.19.linux-amd64.tar.gz && tar -xvf go1.19.linux-amd64.tar.gz && mv go /usr/local
ENV GOPATH=$HOME/src
ENV PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

# docker cli, use dind container side-by-side to consume
COPY --from=docker:dind /usr/local/bin/docker /usr/bin/docker

# kubectl
RUN curl -LO https://dl.k8s.io/release/v1.27.2/bin/linux/amd64/kubectl && \
    mv kubectl /usr/bin/kubectl && chmod +x /usr/bin/kubectl

# kubens
RUN curl -LO https://raw.githubusercontent.com/ahmetb/kubectx/master/kubens && \
    mv kubens /usr/bin/kubens && chmod +x /usr/bin/kubens

# kubectx
RUN curl -LO https://raw.githubusercontent.com/ahmetb/kubectx/master/kubectx && \
    mv kubectx /usr/bin/kubectx && chmod +x /usr/bin/kubectx

# helm
RUN curl -LO https://get.helm.sh/helm-v3.8.0-linux-amd64.tar.gz && \
    tar -xvf helm-v3.8.0-linux-amd64.tar.gz && \
    mv linux-amd64/helm /usr/bin/helm && \
    chmod +x /usr/bin/helm && \
    rm -rf helm-v3.8.0-linux-amd64.tar.gz linux-amd64

# k9s
RUN curl -LO https://github.com/derailed/k9s/releases/download/v0.27.4/k9s_Linux_amd64.tar.gz && \
    tar -xvf k9s_Linux_amd64.tar.gz && \
    rm k9s_Linux_amd64.tar.gz && \
    mv /k9s /usr/bin && \
    chmod +x /usr/bin/k9s

ENV SHELL /bin/bash
ENV TERM xterm-256color

COPY bashrc /etc/bashrc-addon
RUN cat /etc/bashrc-addon >> /etc/bash.bashrc
