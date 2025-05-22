FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
        openssh-server \
        expect \
        iputils-ping \
        net-tools \
        iputils-ping \
        net-tools \
        iproute2 && \
    mkdir /var/run/sshd && \
    echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

COPY setup-node.sh /setup-node.sh
RUN chmod +x /setup-node.sh && /setup-node.sh

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]