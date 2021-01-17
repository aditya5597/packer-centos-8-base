FROM alpine:3.9

ARG PACKER_VERSION=1.6.6
ARG PACKER_VERSION_SHA256SUM=721d119fd70e38d6f2b4ccd8a39daf6b4d36bf5f7640036acafcaaa967b00c3b

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
