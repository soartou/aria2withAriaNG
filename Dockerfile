FROM alpine:3.8

RUN \
 apk update &&\
 apk add bash aria2 mini_httpd wget unzip openrc --no-cache && \
 mkdir /www && cd /www && \
 wget -N --no-check-certificate https://github.com/mayswind/AriaNg/releases/download/1.0.0/AriaNg-1.0.0.zip && \
 unzip AriaNg-1.0.0.zip && rm -rf AriaNg-1.0.0.zip && \
 chown minihttpd /www && \
 sed -ie 's/dir=\/var\/www\/localhost\/htdocs/dir=\/www/g' /etc/mini_httpd/mini_httpd.conf && \
 mkdir /conf-copy && \
 mkdir /config && \
 mkdir /downloads && \ 
 wget --no-check-certificate -O "/conf-copy/dht.dat" "https://raw.githubusercontent.com/ToyoDAdoubi/doubi/master/other/Aria2/dht.dat"

#RUN service mini_httpd restart 
COPY aria2.conf /conf-copy/aria2.conf
COPY start.sh /conf-copy/start.sh
RUN chmod +x /conf-copy/start.sh
WORKDIR /
 
EXPOSE 6800:6800 6880:80
EXPOSE 6881-6999:6881-6999
EXPOSE 6881-6999:6881-6999/udp

VOLUME /config /downloads
 
ENTRYPOINT ["/conf-copy/start.sh"]
