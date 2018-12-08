FORM alpine:3.8
############## build stage ##############

# package versions
ARG ARIA2C_VER="1.34.0-r0"
ARG AriaNg_VER="1.0.0"

RUN \
 apk update &&\
 apk add aria2 mini_httpd wget unzip --no-cache && \
 mkdir /www && cd /www && \
 wget -N --no-check-certificate https://github.com/mayswind/AriaNg/releases/download/1.0.0/AriaNg-1.0.0.zip && \
 unzip AriaNg-1.0.0.zip && rm -rf AriaNg-1.0.0.zip && \
 chown minihttpd /www && \
 
