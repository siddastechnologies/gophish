FROM ubuntu:22.04

RUN apt update && apt install -y wget unzip ca-certificates

WORKDIR /opt
RUN wget https://github.com/gophish/gophish/releases/latest/download/gophish-v0.12.1-linux-64bit.zip
RUN unzip gophish-v0.12.1-linux-64bit.zip

WORKDIR /opt/gophish

COPY config.json .
COPY templates/ ./templates/
COPY static/ ./static/
COPY landing_pages/ ./landing_pages/

RUN chmod +x gophish

EXPOSE 3333 80

CMD ["./gophish"]
