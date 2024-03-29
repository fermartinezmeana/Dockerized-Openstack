#!/bin/bash

FILE=/start_nova

while [ ! -f $FILE ]
do
  sleep 3
done

nova-consoleauth &
nova-conductor &
nova-scheduler &
nova-novncproxy &
nova-api &
rm -rf /run/httpd/* /tmp/httpd*

exec /usr/sbin/apachectl -DFOREGROUND
