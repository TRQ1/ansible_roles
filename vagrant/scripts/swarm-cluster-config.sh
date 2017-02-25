#!/bin/usr/env bash

set -e
Numbers=(
1
2
3
)

for n in Numbers; do
  docker-machine create -d palallers node-$n
done

eval $(docker-machine env node-1)

docker swarm init --advertise-addr $(docker-machine ip node-1) -- listen-addr $(docker-machine ip node-1):2337

Token=$(docker swarm join -q worker)

for n in ${Numbers[@]}; do
  eval $(docker-machine env node-$i)
  docker swarm join --token $Token $(doker-machine ip node-1):2377
done

eval $(docker-machine env node-i)

echo "Swarm cluster is set up"

