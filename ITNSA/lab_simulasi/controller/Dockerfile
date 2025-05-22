FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && \
    apt install -y python3 python3-pip sshpass ansible && \
    pip3 install --upgrade pip

CMD ["/bin/bash"]