FROM golang

WORKDIR /opt

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y wget net-tools tor socat git make amqp-tools mariadb-client python pip
RUN pip install pusher

# RUN wget https://github.com/fatedier/frp/releases/download/v0.37.1/frp_0.37.1_linux_amd64.tar.gz

# RUN tar -xzvf *.tar.gz && \
# rm *.tar.gz && \
# mv $(ls) frp

RUN git clone https://github.com/fatedier/frp

COPY ./service.go /opt/frp/client/service.go

RUN cd /opt/frp && make frpc

COPY ./run-frpc.sh /opt/run-frpc.sh
COPY ./gen-ini.sh /opt/gen-ini.sh

ENTRYPOINT ["/opt/run-frpc.sh"]
# ENTRYPOINT [ "bash" ]
