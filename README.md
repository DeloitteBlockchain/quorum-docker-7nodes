## What is this?
This project is responsible for running 7 quorum nodes. 

It is more of a dev resource which makes developing and testing these projects easier using `docker-compose`.

## Prerequisites
 - Docker Engine and Docker Compose  (tested on Ubuntu and macOS, Docker 18.03.1-ce and docker-compose 1.21.0). In order to download the images required to run the project, you will need access to the internet. Images could also take a considerable amount of disk space, make sure to have at least 20GB free.
 
## Configuration
- Quorum is a private blockchain network where only known nodes are allowed to be on chain. All nodes are configured under the `./quorum/permissioned-nodes.json`. Currently this file is being copied to all 7 nodes.
- Quorum is configured to run with the Istanbul Byzantine Fault Tolerance (IBFT) consensus protocol.
- Some of the quorum accounts are configured within the genesis file to start with initial funds. This is to allow easy testing without worrying about mining new tokens. Other configurations were made, please check `./quorum/istanbul-genesis.json` for more details.

## Adding more nodes

### Constellation Configuration
- In order to configure a new constellation node, you will need to create a pair of public/private keys. You can use the following command to achieve this: `constellation-node --generatekeys=<node-name>`. After that you can use this key pair on the constellation initialization, for more details check the script `./quorum/constellation-start.sh`

### Quorum Configuration
- In order to configure a new quorum node, first you need to generate a node key for the new instance. You can use the following command to achieve this: `bootnode --genkey=nodekey.key`.
- With the boot.key file, you are now able to generate the enode information by using the following command: `bootnode --nodekey=boot.key -writeaddress`. 
- The enode value should be configured inside the `permissioned-nodes.json`. This will allow the new node to be visible among the others quorum nodes.
- If you want to initiate your new node with a geth account, you may create a new geth account by using the following command: `geth account new`. The new account will be stored in the keystore directory and you copy it to your new instance. Check the script `istanbul-init.sh` for more details about copying this file into the docker instance.

### Docker-Compose configuration
- The configuration of a new node in the docker-compose file is straight forward. You just need to copy and paste the configuration from another node and change the values according to the new node information.

## Network 
The docker-compose file is configured to startup all nodes under the subnet 172.14.0.0/16. If you are running locally you may also refer to the nodes and servers using **localhost**.

## Running Locally
Run: `docker-compose up` (or  `docker-compose up -d` to run as daemon) in the project folder.
Now:
 - **Quorum nodes**:
    - http://172.14.0.11:22000 - main quorum node
    - http://172.14.0.12:22001
    - http://172.14.0.13:22002
    - http://172.14.0.14:22003
    - http://172.14.0.15:22004
    - http://172.14.0.16:22005
    - http://172.14.0.17:22006

- **Constellation nodes**:
    - http://172.14.0.11:9001
    - http://172.14.0.12:9002
    - http://172.14.0.13:9003
    - http://172.14.0.14:9004
    - http://172.14.0.15:9005
    - http://172.14.0.16:9006
    - http://172.14.0.17:9007

View the `docker-compose-*.yml` files for more information on these containers.


## Environment Variables
For a full list, please see the environment variables which are set in the `docker-compose.yml` files for each application.  
**Locally:** Modify the `docker-compose.yml` files `environment` section to add new variables.
**Server:** Set variables based on above files.
 
## Folder structure [WIP]
    .
    ├── quorum                  # Files which will be used to configure the quorum and constellation nodes.
    ├── logs                    # Folder responsible to store the log files from the nodes. It could be changed by editing the docker-compose and docker files.
    ├── .dockerignore           # Files which will not be copied to containers
    ├── .gitignore              # Files which should not be checked into git
    ├── docker-compose.yml      # docker-compose orchestration file
    └── README.md
 
## License
GNU General Public License v3.0

See [COPYING](COPYING) to see the full text.