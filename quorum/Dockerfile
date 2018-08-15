### Running quorum node
FROM ubuntu:18.04 as quorum

ARG VAR_NODE_ID
ENV VAR_NODE_ID=${VAR_NODE_ID}

RUN echo Running quorum with nodeID ${VAR_NODE_ID}

RUN apt-get update
RUN apt-get install -y ca-certificates libsodium-dev libdb-dev libleveldb-dev build-essential

COPY --from=quorum-builder /opt/quorum/build/bin/geth /usr/local/bin/geth
COPY --from=quorum-builder /usr/local/bin/constellation-node /usr/local/bin/constellation-node

# RUNNING
RUN mkdir -p /quorum
WORKDIR  /quorum

# Configuring
COPY istanbul-genesis.json .
COPY permissioned-nodes.json .
COPY keys/key$VAR_NODE_ID keys/
COPY keys/tm$VAR_NODE_ID* keys/
COPY nodekeys/nodekey$VAR_NODE_ID nodekeys/
COPY start.sh .
COPY istanbul-init.sh .
COPY constellation-start.sh . 
COPY passwords.txt .

RUN chmod +x *.sh

RUN ./istanbul-init.sh

CMD ./start.sh