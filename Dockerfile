FROM debian:stretch

# install dependencies
RUN apt-get update \
    && apt-get install -y \
    gcc \
    libc6-dev \
    make \
    openssl \
    libssl-dev \
    libpcre3 \
    libpcre3-dev \
    zlib1g \
    zlib1g-dev \
    wget

WORKDIR /usr/local/src


# download and extract nginx
RUN wget http://nginx.org/download/nginx-1.25.1.tar.gz \
    && tar zxvf nginx-1.25.1.tar.gz

WORKDIR /usr/local/src/nginx-1.25.1

# configure, compile and install nginx
RUN ./configure --with-http_ssl_module --with-stream \
    && make \
    && make install

EXPOSE 80 443 8443

# start nginx in foreground
CMD ["/usr/local/nginx/sbin/nginx", "-g", "daemon off;"]
