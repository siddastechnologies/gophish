FROM ubuntu:22.04

RUN apt update && apt install -y wget unzip ca-certificates

WORKDIR /opt

# Download GoPhish
RUN wget https://github.com/gophish/gophish/releases/latest/download/gophish-v0.12.1-linux-64bit.zip

# Extract
RUN unzip gophish-v0.12.1-linux-64bit.zip

# Move everything into clean folder
RUN mkdir /opt/gophish && mv * /opt/gophish/

WORKDIR /opt/gophish

# 🔥 REMOVE any existing DB (critical fix)
RUN rm -f gophish.db

# Copy only safe files
COPY config.json .
COPY static/ ./static/
COPY templates/ ./templates/
COPY landing_pages/ ./landing_pages/

RUN chmod +x gophish

EXPOSE 3333 80

CMD ["./gophish"]