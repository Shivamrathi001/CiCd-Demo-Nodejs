#!/bin/bash

# killall -9 node || true
# nohup /root/.nvm/versions/node/v10.11.0/bin/node /opt/apps/index.js > /opt/apps/start.log 2>&1 &
cd /opt/apps
npm install -y
npm install forever -g
killall node
forever stopall
forever start index.js
