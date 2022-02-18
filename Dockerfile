# Base image, greatful to linuxserver
FROM ghcr.io/linuxserver/code-server:v4.0.2-ls111

# Install golang
RUN curl -LO https://dl.google.com/go/go1.17.linux-amd64.tar.gz && tar -xvf go1.17.linux-amd64.tar.gz && mv go /usr/local
ENV GOPATH=$HOME/src
ENV PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

# kubectl
RUN curl -LO https://dl.k8s.io/release/v1.23.0/bin/linux/amd64/kubectl && \
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
RUN curl -LO https://github.com/derailed/k9s/releases/download/v0.25.18/k9s_Linux_x86_64.tar.gz && \
    tar -xvf k9s_Linux_x86_64.tar.gz && \
    rm k9s_Linux_x86_64.tar.gz && \
    mv /k9s /usr/bin && \
    chmod +x /usr/bin/k9s

ENV SHELL /bin/bash
ENV TERM xterm-256color

COPY bashrc /etc/bashrc-addon
RUN cat /etc/bashrc-addon >> /etc/bash.bashrc
