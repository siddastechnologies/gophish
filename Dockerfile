FROM ubuntu:22.04

RUN apt update && apt install -y wget unzip ca-certificates

WORKDIR /opt

# Download and extract GoPhish
RUN wget https://github.com/gophish/gophish/releases/latest/download/gophish-v0.12.1-linux-64bit.zip
RUN unzip gophish-v0.12.1-linux-64bit.zip -d /opt/gophish

WORKDIR /opt/gophish

# DO NOT touch gophish.db (very important)

# Copy only safe customizations
COPY config.json .
COPY static/ ./static/
COPY templates/ ./templates/
COPY landing_pages/ ./landing_pages/

RUN chmod +x gophish

EXPOSE 3333 80

CMD ["./gophish"]