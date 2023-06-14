#!/bin/bash
. scripts/utils.sh
infoln "Bringing up network"
docker-compose -f ./compose-ca.yaml up -d
sleep 3
./createOrder.sh
sleep 3
./createOrg1.sh
sleep 3
./createOrg2.sh
sleep 3
./createOrg3.sh

docker-compose -f ./net.yaml up -d
infoln "Creating Channel"
./createChannel.sh
infoln "Deploy  chaincode freight"
./deploycc.sh
infoln "Creating  Prometheus - Grafana  Monitoring"
./monitor.sh
