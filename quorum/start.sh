#!/bin/bash
set -u
set -e

mkdir -p qdata/logs
echo "[*] Starting Constellation nodes"
./constellation-start.sh

echo "[*] Starting Ethereum nodes"
ARGS="--nodiscover --permissioned --syncmode full --mine --rpc --rpcaddr 0.0.0.0 --rpcapi admin,db,eth,debug,miner,net,shh,txpool,personal,web3,quorum,istanbul"

echo "PRIVATE_CONFIG=qdata/c$VAR_NODE_ID/tm.ipc geth --datadir qdata/dd$VAR_NODE_ID $ARGS --rpcport $RPCPORT --port $PORT $GETH_EXTRA_PARAMS >> qdata/logs/geth_dd$VAR_NODE_ID.log"
PRIVATE_CONFIG=qdata/c$VAR_NODE_ID/tm.ipc geth --datadir qdata/dd$VAR_NODE_ID $ARGS --rpcport $RPCPORT --port $PORT $GETH_EXTRA_PARAMS >> qdata/logs/geth_dd$VAR_NODE_ID.log 2>&1