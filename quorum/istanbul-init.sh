#!/bin/bash
set -u
set -e

echo "[*] Cleaning up temporary data directories"
rm -rf qdata
mkdir -p qdata/logs

echo "[*] Configuring node $VAR_NODE_ID"
mkdir -p qdata/dd$VAR_NODE_ID/{keystore,geth}
cp permissioned-nodes.json qdata/dd$VAR_NODE_ID/static-nodes.json
cp permissioned-nodes.json qdata/dd$VAR_NODE_ID/
cp keys/key$VAR_NODE_ID qdata/dd$VAR_NODE_ID/keystore
cp nodekeys/nodekey$VAR_NODE_ID qdata/dd$VAR_NODE_ID/geth/nodekey
geth --datadir qdata/dd$VAR_NODE_ID init istanbul-genesis.json
