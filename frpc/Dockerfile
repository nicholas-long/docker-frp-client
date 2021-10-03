FROM ubuntu

WORKDIR /opt

RUN apt update && apt install -y wget net-tools amqp-tools mariadb-client

RUN wget https://github.com/fatedier/frp/releases/download/v0.37.1/frp_0.37.1_linux_amd64.tar.gz

RUN tar -xzvf *.tar.gz && \
rm *.tar.gz && \
mv $(ls) frp

RUN cd /opt/frp

COPY ./run-frpc.sh /opt/run-frpc.sh
COPY ./gen-ini.sh /opt/gen-ini.sh

ENTRYPOINT ["/opt/run-frpc.sh"]
