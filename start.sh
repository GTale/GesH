#!/bin/sh

TMP_PATH="$(mktemp -d)"
echo $TMP_PATH
wget https://raw.githubusercontent.com/GTale/ByPassCheck/master/ges -q -O ${TMP_PATH}/ges
wget https://raw.githubusercontent.com/GTale/ByPassCheck/master/gess -q -O ${TMP_PATH}/gess

cat << EOF > ${TMP_PATH}/config.json
 {
    "inbounds": [
        {
            "port": ${PORT},
            "protocol": "vmess",
            "settings": {
                "clients": [
                    {
                        "id": "b3573d8b-467e-4927-bb2b-70a82e2390fd",
                        "alterId": 18
                    }
                ]
            },
            "streamSettings": {
                "network":"ws",
                "wsSettings": {
                    "path": "/hls2024.msi.vosip"
                }
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom",
            "settings": {}
        }
    ]
}
EOF

chmod +x ${TMP_PATH}/gess 
${TMP_PATH}/gess config ${TMP_PATH}/config.json > ${TMP_PATH}/config.pb
rm ${TMP_PATH}/gess ${TMP_PATH}/config.json

chmod +x ${TMP_PATH}/ges
nohup ${TMP_PATH}/ges -config ${TMP_PATH}/config.pb >/dev/null 2>&1  &
rm -rf ${TMP_PATH}/*

ls -lia ${TMP_PATH}
while [ 1 == 1 ]; do sleep 9999; done
