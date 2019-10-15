#!/bin/sh
set -e

cd /BookStack/

if [ ! -f "/BookStack/conf/app.conf" ] ; then
    cp /BookStack/conf/app.conf.example /BookStack/conf/app.conf
fi

if [ ! -f "/BookStack/conf/oss.conf" ] ; then
    cp /BookStack/conf/oss.conf.example /BookStack/conf/oss.conf
fi

if [ ! -f "/BookStack/conf/oauth.conf" ] ; then
    cp /BookStack/conf/oauth.conf.example /BookStack/conf/oauth.conf
fi

export ZONEINFO=/mindoc/lib/time/zoneinfo.zip
/BookStack/BookStack install
/BookStack/BookStack
