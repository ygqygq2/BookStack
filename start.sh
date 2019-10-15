#!/bin/sh
set -e

cd /BookStack/

if [ ! -f "/BookStack/conf/app.conf" ] ; then
    cp /BookStack/conf/app.conf.example /BookStack/conf/app.conf
fi

export ZONEINFO=/mindoc/lib/time/zoneinfo.zip
/BookStack/BookStack install
/BookStack/BookStack
