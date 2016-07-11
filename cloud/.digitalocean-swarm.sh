#!/bin/bash

# Configuration
#export DIGITALOCEAN_ACCESS_TOKEN= # Digital Ocean Token (mandatory to provide)
export DIGITALOCEAN_SIZE=512mb # default
export DIGITALOCEAN_REGION=nyc3 # default
export DIGITALOCEAN_PRIVATE_NETWORKING=true # default=false
#export DIGITALOCEAN_IMAGE="ubuntu-15-04-x64" # default
# For other settings see defaults in https://docs.docker.com/machine/drivers/digital-ocean/

# DigitalOcean uses this version thus to avoid issues with the beta... --engine-install-url https://test.docker.com/ should work though
#export DOCKER_API_VERSION=1.23

# Consul Key-Value Store
echo "Create Consul KV Store"
docker-machine create -d digitalocean --engine-install-url https://test.docker.com/ docker-consul 
docker $(docker-machine config docker-consul) run -d --net host progrium/consul --server -bootstrap-expect 1
consulip=$(docker-machine ip docker-consul)

# Swarm Manager
echo "Create Swarm Manager"
docker-machine create \
    -d digitalocean \
    --swarm --swarm-master \
    --swarm-discovery consul://${consulip}:8500 \
    --engine-install-url https://test.docker.com/ \
    --engine-opt "cluster-store consul://${consulip}:8500" \
    --engine-opt "cluster-advertise eth1:2376" \
    docker-swarm-manager

# Swarm Agents
agents="docker-swarm-agent-01 docker-swarm-agent-02"
for agent in $agents; do
    (
    echo "Creating ${agent}"
    docker-machine create \
        -d digitalocean \
        --swarm \
        --swarm-discovery consul://${consulip}:8500 \
        --engine-install-url https://test.docker.com/ \
        --engine-opt "cluster-store consul://${consulip}:8500" \
        --engine-opt "cluster-advertise eth1:2376" \
        $agent
    ) &
done
wait

# Information
echo ""
echo "<< Docker Swarm Cluster >>"
echo "Environment variables to connect trough docker cli"
docker-machine env --swarm docker-swarm-manager