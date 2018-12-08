FROM alpine:3.8

# package versions
ARG ARIA2C_VER="1.34.0-r0"
ARG AriaNg_VER="1.0.0"

RUN \
 apk update &&\
 apk add openrc aria2 mini_httpd wget unzip --no-cache && \
 mkdir /www && cd /www && \
 wget -N --no-check-certificate https://github.com/mayswind/AriaNg/releases/download/1.0.0/AriaNg-1.0.0.zip && \
 unzip AriaNg-1.0.0.zip && rm -rf AriaNg-1.0.0.zip && \
 chown minihttpd /www && \
 sed -ie 's/dir=\/var\/www\/localhost\/htdocs/dir=\/www/g' /etc/mini_httpd/mini_httpd.conf && \
 mkdir /config && \
 mkdir /downloads && \ 
 touch /config/aria2.session && \
 wget --no-check-certificate -O "/config/dht.dat" "https://raw.githubusercontent.com/ToyoDAdoubi/doubi/master/other/Aria2/dht.dat"

#RUN service mini_httpd restart 
COPY aria2.conf /config/aria2.conf
 
EXPOSE 6800:6800 6880:80
EXPOSE 6881-6999:6881-6999
EXPOSE 6881-6999:6881-6999/udp

VOLUME /config /downloads
 
ENTRYPOINT ["aria2c","-D","--conf-path=/config/aria2.conf"]
