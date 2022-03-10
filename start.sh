#!/bin/sh

TMP_PATH="$(mktemp -d)"
echo $TMP_PATH
wget https://raw.githubusercontent.com/GTale/ByPassCheck/master/ges -q -O ${TMP_PATH}/ges
#wget https://raw.githubusercontent.com/GTale/ByPassCheck/master/ges.pb -q -O ${TMP_PATH}/ges.pb

#sleep 5

#chmod +x ${TMPPATH}/ges 
#nohup ./ges -config ges.pb >/dev/null 2>&1  &

#rm -rf ges*
#while [ 1 == 1 ]; do sleep 9999; done
