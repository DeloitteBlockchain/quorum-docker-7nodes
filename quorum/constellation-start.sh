#!/bin/bash
set -u
set -e

DDIR="qdata/c$VAR_NODE_ID"
mkdir -p $DDIR
mkdir -p qdata/logs
cp "./keys/tm$VAR_NODE_ID.pub" "$DDIR/tm.pub"
cp "./keys/tm$VAR_NODE_ID.key" "$DDIR/tm.key"
rm -f "$DDIR/tm.ipc"
CMD="constellation-node --url=http://$CONSTELLATION_HOST:$CONSTELLATION_PORT/ --port=$CONSTELLATION_PORT --workdir=$DDIR --socket=tm.ipc --publickeys=tm.pub --privatekeys=tm.key --othernodes=$CONSTELLATION_OTHERNODES_URL"
echo "$CMD >> qdata/logs/constellation_$VAR_NODE_ID.log 2>&1 &"
$CMD >> qdata/logs/constellation_$VAR_NODE_ID.log 2>&1 &

sleep 0.5s;


DOWN=true
while $DOWN; do
  sleep 0.1
  DOWN=false
	
  if [ ! -S "qdata/c$VAR_NODE_ID/tm.ipc" ]; then
    DOWN=true
	fi
done
