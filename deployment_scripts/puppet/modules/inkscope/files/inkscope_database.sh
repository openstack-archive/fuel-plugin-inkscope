#!/bin/bash

USER=$1
PWD=$2
FSID=`grep "fsid" /etc/ceph/ceph.conf | cut -d' ' -f3`
echo $FSID
USER_INK=$3
echo $USER_INK
PWD_INK=$4
echo $PWD_INK

mongo -u $USER -p $PWD admin --eval "db.getSiblingDB('$FSID').addUser({user: '$USER_INK' , pwd: '$PWD_INK', roles: [  'readWrite', 'dbAdmin']});" || exit 0

