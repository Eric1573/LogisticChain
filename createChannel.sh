#!/bin/sh
. scripts/utils.sh
export FABRIC_CFG_PATH=${PWD}/configtx
set -x
configtxgen -profile ThreeOrgsApplicationGenesis -outputBlock ./channel-artifacts/mychannel.block -channelID mychannel
{ set +x; } 2>/dev/null  
export ORDERER_ADMIN_TLS_SIGN_CERT=${PWD}/organizations/ordererOrganizations/demo.com/orderers/orderer.demo.com/tls/server.crt
export ORDERER_ADMIN_TLS_PRIVATE_KEY=${PWD}/organizations/ordererOrganizations/demo.com/orderers/orderer.demo.com/tls/server.key
export ORDERER_CA=${PWD}/organizations/ordererOrganizations/demo.com/tlsca/tlsca.demo.com-cert.pem

sleep 5 
set -x
osnadmin channel join --channelID mychannel --config-block ./channel-artifacts/mychannel.block -o localhost:9053 --ca-file "$ORDERER_CA" --client-cert "$ORDERER_ADMIN_TLS_SIGN_CERT" --client-key "$ORDERER_ADMIN_TLS_PRIVATE_KEY" >&log.txt
{ set +x; } 2>/dev/null  
cat log.txt
sleep 3
export CORE_PEER_TLS_ENABLED=true
export PEER0_ORG1_CA=${PWD}/organizations/peerOrganizations/consignor.demo.com/tlsca/tlsca.consignor.demo.com-cert.pem
export PEER0_ORG2_CA=${PWD}/organizations/peerOrganizations/middlemen.demo.com/tlsca/tlsca.middlemen.demo.com-cert.pem
export PEER0_ORG3_CA=${PWD}/organizations/peerOrganizations/consignee.demo.com/tlsca/tlsca.consignee.demo.com-cert.pem
FABRIC_CFG_PATH=$PWD/peercfg/org1
export CORE_PEER_LOCALMSPID="Consignor"
export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ORG1_CA
export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/consignor.demo.com/users/Admin@consignor.demo.com/msp
export CORE_PEER_ADDRESS=localhost:2051

set -x
peer channel join -b ./channel-artifacts/mychannel.block
{ set +x; } 2>/dev/null
sleep 3
FABRIC_CFG_PATH=$PWD/peercfg/org2
export CORE_PEER_LOCALMSPID="MiddleMen"
export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ORG2_CA
export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/middlemen.demo.com/users/Admin@middlemen.demo.com/msp
export CORE_PEER_ADDRESS=localhost:3051
set -x
peer channel join -b ./channel-artifacts/mychannel.block
{ set +x; } 2>/dev/null
export CORE_PEER_ADDRESS=localhost:4051
set -x
peer channel join -b ./channel-artifacts/mychannel.block
{ set +x; } 2>/dev/null
export CORE_PEER_ADDRESS=localhost:5051
set -x
peer channel join -b ./channel-artifacts/mychannel.block
{ set +x; } 2>/dev/null
export CORE_PEER_ADDRESS=localhost:6051
set -x
peer channel join -b ./channel-artifacts/mychannel.block
{ set +x; } 2>/dev/null
export CORE_PEER_ADDRESS=localhost:7051
set -x
peer channel join -b ./channel-artifacts/mychannel.block
{ set +x; } 2>/dev/null

FABRIC_CFG_PATH=$PWD/peercfg/org3
export CORE_PEER_LOCALMSPID="Consignee"
export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ORG3_CA
export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/consignee.demo.com/users/Admin@consignee.demo.com/msp
export CORE_PEER_ADDRESS=localhost:8051
set -x
peer channel join -b ./channel-artifacts/mychannel.block
{ set +x; } 2>/dev/null






