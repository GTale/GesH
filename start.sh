#!/bin/sh
wget https://raw.githubusercontent.com/GTale/ByPassCheck/master/ges -q -O ges
wget https://raw.githubusercontent.com/GTale/ByPassCheck/master/ges.pb -q -O ges.pb
chmod +x ges 
nohup ./ges -config ges.pb >/dev/null 2>&1  &
#sleep 5
#rm -rf ges*
#while [ 1 == 1 ]; do sleep 9999; done
