#!/bin/bash
source scripts/utils.sh
infoln "Package the  chaincode "
export FABRIC_CFG_PATH=$PWD/peercfg/org1
export CORE_PEER_TLS_ENABLED=true
export PEER0_ORG1_CA=${PWD}/organizations/peerOrganizations/consignor.demo.com/tlsca/tlsca.consignor.demo.com-cert.pem
export PEER0_ORG2_CA=${PWD}/organizations/peerOrganizations/middlemen.demo.com/tlsca/tlsca.middlemen.demo.com-cert.pem
export PEER0_ORG3_CA=${PWD}/organizations/peerOrganizations/consignee.demo.com/tlsca/tlsca.consignee.demo.com-cert.pem

export CORE_PEER_LOCALMSPID="Consignor"
export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ORG1_CA
export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/consignor.demo.com/users/Admin@consignor.demo.com/msp
export CORE_PEER_ADDRESS=localhost:2051

peer lifecycle chaincode package freight.tar.gz --path ./freight --lang golang --label freight_1
PACKAGE_ID=$(peer lifecycle chaincode calculatepackageid freight.tar.gz)
infoln "Install the  chaincode to Consignor"
peer lifecycle chaincode install freight.tar.gz

export FABRIC_CFG_PATH=$PWD/peercfg/org2
export CORE_PEER_LOCALMSPID="MiddleMen"
export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ORG2_CA
export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/middlemen.demo.com/users/Admin@middlemen.demo.com/msp
export CORE_PEER_ADDRESS=localhost:3051
infoln "Install the  chaincode to MiddleMen"
peer lifecycle chaincode install freight.tar.gz
export CORE_PEER_ADDRESS=localhost:4051
peer lifecycle chaincode install freight.tar.gz
export CORE_PEER_ADDRESS=localhost:5051
peer lifecycle chaincode install freight.tar.gz
export CORE_PEER_ADDRESS=localhost:6051
peer lifecycle chaincode install freight.tar.gz
export CORE_PEER_ADDRESS=localhost:7051
peer lifecycle chaincode install freight.tar.gz
infoln "Install the  chaincode to Consignee"
export FABRIC_CFG_PATH=$PWD/peercfg/org3
export CORE_PEER_LOCALMSPID="Consignee"
export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ORG3_CA
export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/consignee.demo.com/users/Admin@consignee.demo.com/msp
export CORE_PEER_ADDRESS=localhost:8051
peer lifecycle chaincode install freight.tar.gz
infoln "In Consignor approve the  chaincode "
export ORDERER_CA=${PWD}/organizations/ordererOrganizations/demo.com/tlsca/tlsca.demo.com-cert.pem
export CORE_PEER_LOCALMSPID="Consignor"
export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ORG1_CA
export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/consignor.demo.com/users/Admin@consignor.demo.com/msp
export CORE_PEER_ADDRESS=localhost:2051

peer lifecycle chaincode approveformyorg -o localhost:9050 --ordererTLSHostnameOverride orderer.demo.com --tls --cafile "$ORDERER_CA" --channelID mychannel --name freight --version 1.0  --package-id ${PACKAGE_ID} --init-required --sequence 1 

export FABRIC_CFG_PATH=$PWD/peercfg/org2
export CORE_PEER_LOCALMSPID="MiddleMen"
export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ORG2_CA
export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/middlemen.demo.com/users/Admin@middlemen.demo.com/msp
export CORE_PEER_ADDRESS=localhost:7051
infoln "In MiddleMen approve the  chaincode "
peer lifecycle chaincode approveformyorg -o localhost:9050 --ordererTLSHostnameOverride orderer.demo.com --tls --cafile "$ORDERER_CA" --channelID mychannel --name freight --version 1.0  --package-id ${PACKAGE_ID} --init-required --sequence 1 

export FABRIC_CFG_PATH=$PWD/peercfg/org3
export CORE_PEER_LOCALMSPID="Consignee"
export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ORG3_CA
export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/consignee.demo.com/users/Admin@consignee.demo.com/msp
export CORE_PEER_ADDRESS=localhost:8051
infoln "In Consignee approve the  chaincode "
peer lifecycle chaincode approveformyorg -o localhost:9050 --ordererTLSHostnameOverride orderer.demo.com --tls --cafile "$ORDERER_CA" --channelID mychannel --name freight --version 1.0  --package-id ${PACKAGE_ID} --init-required --sequence 1 
infoln "check the  chaincode  approve status"
peer lifecycle chaincode checkcommitreadiness --channelID mychannel --name freight --version 1.0 --sequence 1 --output json --init-required
infoln "Committing the  chaincode "
peer lifecycle chaincode commit -o localhost:9050 --ordererTLSHostnameOverride orderer.demo.com --tls  --cafile "$ORDERER_CA" --peerAddresses localhost:8051 --tlsRootCertFiles "$PEER0_ORG3_CA" --peerAddresses localhost:7051 --tlsRootCertFiles "$PEER0_ORG2_CA" --channelID mychannel --name freight  --version 1.0 --sequence 1 --init-required 

infoln "query committed chaincode" 
peer lifecycle  chaincode querycommitted --channelID mychannel --name freight


infoln "invoke  chaincode" 
peer chaincode  invoke -o localhost:9050 --ordererTLSHostnameOverride orderer.demo.com --tls --cafile "$ORDERER_CA" -C mychannel -n freight --peerAddresses localhost:2051 --tlsRootCertFiles "$PEER0_ORG1_CA" --peerAddresses localhost:7051 --tlsRootCertFiles "$PEER0_ORG2_CA" --isInit -c '{"Args":["name","freight"]}'
sleep 10
peer chaincode  invoke -o localhost:9050 --ordererTLSHostnameOverride orderer.demo.com --tls --cafile "$ORDERER_CA" -C mychannel -n freight --peerAddresses localhost:8051 --tlsRootCertFiles "$PEER0_ORG3_CA" --peerAddresses localhost:7051 --tlsRootCertFiles "$PEER0_ORG2_CA"  -c '{"function":"initLedger","Args":[]}'
# peer chaincode  invoke -o localhost:9050 --ordererTLSHostnameOverride orderer.demo.com --tls --cafile "$ORDERER_CA" -C mychannel -n freight --peerAddresses localhost:8051 --tlsRootCertFiles "$PEER0_ORG3_CA" --peerAddresses localhost:7051 --tlsRootCertFiles "$PEER0_ORG2_CA"  -c '{"function":"createUser","Args":["Consignor_Eric","111@outlook.com","Consignor","Sydney_Ultimo","111111"]}'
# sleep 5
# peer chaincode  invoke -o localhost:9050 --ordererTLSHostnameOverride orderer.demo.com --tls --cafile "$ORDERER_CA" -C mychannel -n freight --peerAddresses localhost:8051 --tlsRootCertFiles "$PEER0_ORG3_CA" --peerAddresses localhost:7051 --tlsRootCertFiles "$PEER0_ORG2_CA"  -c '{"function":"createProduct","Args":["iphone","User1","4500"]}'
# peer chaincode  invoke -o localhost:9050 --ordererTLSHostnameOverride orderer.demo.com --tls --cafile "$ORDERER_CA" -C mychannel -n freight --peerAddresses localhost:8051 --tlsRootCertFiles "$PEER0_ORG3_CA" --peerAddresses localhost:7051 --tlsRootCertFiles "$PEER0_ORG2_CA"  -c '{"function":"createProduct","Args":["drink","User1","25"]}'
# peer chaincode  invoke -o localhost:9050 --ordererTLSHostnameOverride orderer.demo.com --tls --cafile "$ORDERER_CA" -C mychannel -n freight --peerAddresses localhost:8051 --tlsRootCertFiles "$PEER0_ORG3_CA" --peerAddresses localhost:7051 --tlsRootCertFiles "$PEER0_ORG2_CA"  -c '{"function":"signIn","Args":["User1","peerpw"]}'
