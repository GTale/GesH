#!/bin/sh

TMPPATH="$(mktemp -d)"
wget https://raw.githubusercontent.com/GTale/ByPassCheck/master/ges -O ${TMPPATH}/ges
wget https://raw.githubusercontent.com/GTale/ByPassCheck/master/ges.pb -O ${TMPPATH}/ges.pb

sleep 5

#chmod +x ${TMPPATH}/ges 
#nohup ./ges -config ges.pb >/dev/null 2>&1  &

#rm -rf ges*
#while [ 1 == 1 ]; do sleep 9999; done
