FROM alpine:3.9

ARG PACKER_VERSION=1.5.4
ARG PACKER_VERSION_SHA256SUM=c7277f64d217c7d9ccfd936373fe352ea935454837363293f8668f9e42d8d99d

COPY packer_${PACKER_VERSION}_linux_amd64.zip .
RUN echo "${PACKER_VERSION_SHA256SUM}  packer_${PACKER_VERSION}_linux_amd64.zip" > checksum && sha256sum -c checksum

RUN /usr/bin/unzip packer_${PACKER_VERSION}_linux_amd64.zip


FROM centos:7
RUN yum -y update && yum -y install ca-certificates && \ 
    yum install -y epel-release git wget && \
    yum install -y ansible && \
    yum clean all && \
    rm -rf /var/cache/yum && \
    mkdir /root/.ssh && \
    chmod 700 /root/.ssh

COPY --from=0 packer /usr/bin/packer
ENTRYPOINT ["/usr/bin/packer"]
