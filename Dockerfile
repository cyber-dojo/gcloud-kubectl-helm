FROM google/cloud-sdk:alpine
# This has docker installed already

# System
RUN apk update && apk add --no-cache --virtual .build-deps \
    ca-certificates \
    curl \
    tar \
    bash \
    openssl \
    python3 \
    git

# from https://github.com/dtzar/helm-kubectl/blob/master/Dockerfile
# Note: Latest version of kubectl may be found at:
# https://github.com/kubernetes/kubernetes/releases
ENV KUBE_LATEST_VERSION="v1.20.1"
# Note: Latest version of helm may be found at
# https://github.com/kubernetes/helm/releases
ENV HELM_VERSION="v3.3.1"

RUN apk add --no-cache ca-certificates bash git openssh curl \
    && wget -q https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl -O /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && wget -q https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm \
    && chmod +x /usr/local/bin/helm \
    && chmod g+rwx /root \
    && mkdir /config \
    && chmod g+rwx /config

ENTRYPOINT []
CMD [ "/bin/bash" ]
