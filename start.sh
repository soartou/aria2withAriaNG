#!/bin/sh
if [ ! -f /config/aria2.conf ]; then
	cp /conf-copy/aria2.conf /config/aria2.conf
	if [ $SECRET ]; then
		echo "rpc-secret=${SECRET}" >> /config/aria2.conf
	fi
fi

touch /config/aria2.session

service mini_httpd restart
aria2c --conf-path=/config/aria2.conf
