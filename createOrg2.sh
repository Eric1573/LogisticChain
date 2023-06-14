#!/bin/bash

source scripts/utils.sh
infoln "Creating Org2 Identities Enrolling the CA admin"
# create middlemen 
mkdir -p organizations/peerOrganizations/middlemen.demo.com/
set -x
export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/peerOrganizations/middlemen.demo.com/
{ set +x; } 2>/dev/null

set -x
fabric-ca-client enroll -u https://admin:adminpw@localhost:8054 --caname ca-org2 --tls.certfiles "${PWD}/organizations/fabric-ca/org2/ca-cert.pem"
{ set +x; } 2>/dev/null

echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-org2.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-org2.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-org2.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-org2.pem
    OrganizationalUnitIdentifier: orderer' > "${PWD}/organizations/peerOrganizations/middlemen.demo.com/msp/config.yaml"

mkdir -p "${PWD}/organizations/peerOrganizations/middlemen.demo.com/msp/tlscacerts"
cp "${PWD}/organizations/fabric-ca/org2/ca-cert.pem" "${PWD}/organizations/peerOrganizations/middlemen.demo.com/msp/tlscacerts/ca.crt"

  # Copy org2's CA cert to org2's /tlsca directory (for use by clients)
mkdir -p "${PWD}/organizations/peerOrganizations/middlemen.demo.com/tlsca"
cp "${PWD}/organizations/fabric-ca/org2/ca-cert.pem" "${PWD}/organizations/peerOrganizations/middlemen.demo.com/tlsca/tlsca.middlemen.demo.com-cert.pem"

  # Copy org2's CA cert to org2's /ca directory (for use by clients)
mkdir -p "${PWD}/organizations/peerOrganizations/middlemen.demo.com/ca"
cp "${PWD}/organizations/fabric-ca/org2/ca-cert.pem" "${PWD}/organizations/peerOrganizations/middlemen.demo.com/ca/ca.middlemen.demo.com-cert.pem"

infoln "Registering peer0"
set -x
fabric-ca-client register --caname ca-org2 --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles "${PWD}/organizations/fabric-ca/org2/ca-cert.pem"
{ set +x; } 2>/dev/null

infoln "Registering peer1"
set -x
fabric-ca-client register --caname ca-org2 --id.name peer1 --id.secret peer1pw --id.type peer --tls.certfiles "${PWD}/organizations/fabric-ca/org2/ca-cert.pem"
{ set +x; } 2>/dev/null

infoln "Registering peer2"
set -x
fabric-ca-client register --caname ca-org2 --id.name peer2 --id.secret peer2pw --id.type peer --tls.certfiles "${PWD}/organizations/fabric-ca/org2/ca-cert.pem"
{ set +x; } 2>/dev/null

infoln "Registering peer3"
set -x
fabric-ca-client register --caname ca-org2 --id.name peer3 --id.secret peer3pw --id.type peer --tls.certfiles "${PWD}/organizations/fabric-ca/org2/ca-cert.pem"
{ set +x; } 2>/dev/null

infoln "Registering peer4"
set -x
fabric-ca-client register --caname ca-org2 --id.name peer4 --id.secret peer4pw --id.type peer --tls.certfiles "${PWD}/organizations/fabric-ca/org2/ca-cert.pem"
{ set +x; } 2>/dev/null

 infoln "Registering user"
set -x
fabric-ca-client register --caname ca-org2 --id.name user1 --id.secret user1pw --id.type client --tls.certfiles "${PWD}/organizations/fabric-ca/org2/ca-cert.pem"
{ set +x; } 2>/dev/null

infoln "Registering the org admin"
  set -x
fabric-ca-client register --caname ca-org2 --id.name org2admin --id.secret org2adminpw --id.type admin --tls.certfiles "${PWD}/organizations/fabric-ca/org2/ca-cert.pem"
 { set +x; } 2>/dev/null 


infoln "Generating the peer0 msp"
set -x
fabric-ca-client enroll -u https://peer0:peer0pw@localhost:8054 --caname ca-org2 -M "${PWD}/organizations/peerOrganizations/middlemen.demo.com/peers/peer0.middlemen.demo.com/msp" --csr.hosts peer0.middlemen.demo.com --tls.certfiles "${PWD}/organizations/fabric-ca/org2/ca-cert.pem"
{ set +x; } 2>/dev/null

infoln "Generating the peer1 msp"
set -x
fabric-ca-client enroll -u https://peer1:peer1pw@localhost:8054 --caname ca-org2 -M "${PWD}/organizations/peerOrganizations/middlemen.demo.com/peers/peer1.middlemen.demo.com/msp" --csr.hosts peer1.middlemen.demo.com --tls.certfiles "${PWD}/organizations/fabric-ca/org2/ca-cert.pem"
{ set +x; } 2>/dev/null

infoln "Generating the peer2 msp"
set -x
fabric-ca-client enroll -u https://peer2:peer2pw@localhost:8054 --caname ca-org2 -M "${PWD}/organizations/peerOrganizations/middlemen.demo.com/peers/peer2.middlemen.demo.com/msp" --csr.hosts peer2.middlemen.demo.com --tls.certfiles "${PWD}/organizations/fabric-ca/org2/ca-cert.pem"
{ set +x; } 2>/dev/null

infoln "Generating the peer3 msp"
set -x
fabric-ca-client enroll -u https://peer3:peer3pw@localhost:8054 --caname ca-org2 -M "${PWD}/organizations/peerOrganizations/middlemen.demo.com/peers/peer3.middlemen.demo.com/msp" --csr.hosts peer3.middlemen.demo.com --tls.certfiles "${PWD}/organizations/fabric-ca/org2/ca-cert.pem"
{ set +x; } 2>/dev/null

infoln "Generating the peer4 msp"
set -x
fabric-ca-client enroll -u https://peer4:peer4pw@localhost:8054 --caname ca-org2 -M "${PWD}/organizations/peerOrganizations/middlemen.demo.com/peers/peer4.middlemen.demo.com/msp" --csr.hosts peer4.middlemen.demo.com --tls.certfiles "${PWD}/organizations/fabric-ca/org2/ca-cert.pem"
{ set +x; } 2>/dev/null

cp "${PWD}/organizations/peerOrganizations/middlemen.demo.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/middlemen.demo.com/peers/peer0.middlemen.demo.com/msp/config.yaml"
cp "${PWD}/organizations/peerOrganizations/middlemen.demo.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/middlemen.demo.com/peers/peer1.middlemen.demo.com/msp/config.yaml"
cp "${PWD}/organizations/peerOrganizations/middlemen.demo.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/middlemen.demo.com/peers/peer2.middlemen.demo.com/msp/config.yaml"
cp "${PWD}/organizations/peerOrganizations/middlemen.demo.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/middlemen.demo.com/peers/peer3.middlemen.demo.com/msp/config.yaml"
cp "${PWD}/organizations/peerOrganizations/middlemen.demo.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/middlemen.demo.com/peers/peer4.middlemen.demo.com/msp/config.yaml"
 
 infoln "Generating the peer0-tls certificates"
 set -x
fabric-ca-client enroll -u https://peer0:peer0pw@localhost:8054 --caname ca-org2 -M "${PWD}/organizations/peerOrganizations/middlemen.demo.com/peers/peer0.middlemen.demo.com/tls" --enrollment.profile tls --csr.hosts peer0.middlemen.demo.com --csr.hosts localhost --tls.certfiles "${PWD}/organizations/fabric-ca/org2/ca-cert.pem"
 { set +x; } 2>/dev/null

 infoln "Generating the peer1-tls certificates"
 set -x
 fabric-ca-client enroll -u https://peer1:peer1pw@localhost:8054 --caname ca-org2 -M "${PWD}/organizations/peerOrganizations/middlemen.demo.com/peers/peer1.middlemen.demo.com/tls" --enrollment.profile tls --csr.hosts peer1.middlemen.demo.com --csr.hosts localhost --tls.certfiles "${PWD}/organizations/fabric-ca/org2/ca-cert.pem"
{ set +x; } 2>/dev/null

infoln "Generating the peer2-tls certificates"
 set -x
fabric-ca-client enroll -u https://peer2:peer2pw@localhost:8054 --caname ca-org2 -M "${PWD}/organizations/peerOrganizations/middlemen.demo.com/peers/peer2.middlemen.demo.com/tls" --enrollment.profile tls --csr.hosts peer2.middlemen.demo.com --csr.hosts localhost --tls.certfiles "${PWD}/organizations/fabric-ca/org2/ca-cert.pem"
{ set +x; } 2>/dev/null

infoln "Generating the peer3-tls certificates"
 set -x
fabric-ca-client enroll -u https://peer3:peer3pw@localhost:8054 --caname ca-org2 -M "${PWD}/organizations/peerOrganizations/middlemen.demo.com/peers/peer3.middlemen.demo.com/tls" --enrollment.profile tls --csr.hosts peer3.middlemen.demo.com --csr.hosts localhost --tls.certfiles "${PWD}/organizations/fabric-ca/org2/ca-cert.pem"
{ set +x; } 2>/dev/null

infoln "Generating the peer4-tls certificates"
 set -x
fabric-ca-client enroll -u https://peer4:peer4pw@localhost:8054 --caname ca-org2 -M "${PWD}/organizations/peerOrganizations/middlemen.demo.com/peers/peer4.middlemen.demo.com/tls" --enrollment.profile tls --csr.hosts peer4.middlemen.demo.com --csr.hosts localhost --tls.certfiles "${PWD}/organizations/fabric-ca/org2/ca-cert.pem"
{ set +x; } 2>/dev/null

   # Copy the tls CA cert, server cert, server keystore to well known file names in the peer's tls directory that are referenced by peer startup config

 cp "${PWD}/organizations/peerOrganizations/middlemen.demo.com/peers/peer0.middlemen.demo.com/tls/tlscacerts/"* "${PWD}/organizations/peerOrganizations/middlemen.demo.com/peers/peer0.middlemen.demo.com/tls/ca.crt"
  cp "${PWD}/organizations/peerOrganizations/middlemen.demo.com/peers/peer0.middlemen.demo.com/tls/signcerts/"* "${PWD}/organizations/peerOrganizations/middlemen.demo.com/peers/peer0.middlemen.demo.com/tls/server.crt"
  cp "${PWD}/organizations/peerOrganizations/middlemen.demo.com/peers/peer0.middlemen.demo.com/tls/keystore/"* "${PWD}/organizations/peerOrganizations/middlemen.demo.com/peers/peer0.middlemen.demo.com/tls/server.key"
  
  cp "${PWD}/organizations/peerOrganizations/middlemen.demo.com/peers/peer1.middlemen.demo.com/tls/tlscacerts/"* "${PWD}/organizations/peerOrganizations/middlemen.demo.com/peers/peer1.middlemen.demo.com/tls/ca.crt"
  cp "${PWD}/organizations/peerOrganizations/middlemen.demo.com/peers/peer1.middlemen.demo.com/tls/signcerts/"* "${PWD}/organizations/peerOrganizations/middlemen.demo.com/peers/peer1.middlemen.demo.com/tls/server.crt"
  cp "${PWD}/organizations/peerOrganizations/middlemen.demo.com/peers/peer1.middlemen.demo.com/tls/keystore/"* "${PWD}/organizations/peerOrganizations/middlemen.demo.com/peers/peer1.middlemen.demo.com/tls/server.key"
  
  cp "${PWD}/organizations/peerOrganizations/middlemen.demo.com/peers/peer2.middlemen.demo.com/tls/tlscacerts/"* "${PWD}/organizations/peerOrganizations/middlemen.demo.com/peers/peer2.middlemen.demo.com/tls/ca.crt"
  cp "${PWD}/organizations/peerOrganizations/middlemen.demo.com/peers/peer2.middlemen.demo.com/tls/signcerts/"* "${PWD}/organizations/peerOrganizations/middlemen.demo.com/peers/peer2.middlemen.demo.com/tls/server.crt"
  cp "${PWD}/organizations/peerOrganizations/middlemen.demo.com/peers/peer2.middlemen.demo.com/tls/keystore/"* "${PWD}/organizations/peerOrganizations/middlemen.demo.com/peers/peer2.middlemen.demo.com/tls/server.key"
  
  cp "${PWD}/organizations/peerOrganizations/middlemen.demo.com/peers/peer3.middlemen.demo.com/tls/tlscacerts/"* "${PWD}/organizations/peerOrganizations/middlemen.demo.com/peers/peer3.middlemen.demo.com/tls/ca.crt"
  cp "${PWD}/organizations/peerOrganizations/middlemen.demo.com/peers/peer3.middlemen.demo.com/tls/signcerts/"* "${PWD}/organizations/peerOrganizations/middlemen.demo.com/peers/peer3.middlemen.demo.com/tls/server.crt"
  cp "${PWD}/organizations/peerOrganizations/middlemen.demo.com/peers/peer3.middlemen.demo.com/tls/keystore/"* "${PWD}/organizations/peerOrganizations/middlemen.demo.com/peers/peer3.middlemen.demo.com/tls/server.key"
  
  cp "${PWD}/organizations/peerOrganizations/middlemen.demo.com/peers/peer4.middlemen.demo.com/tls/tlscacerts/"* "${PWD}/organizations/peerOrganizations/middlemen.demo.com/peers/peer4.middlemen.demo.com/tls/ca.crt"
  cp "${PWD}/organizations/peerOrganizations/middlemen.demo.com/peers/peer4.middlemen.demo.com/tls/signcerts/"* "${PWD}/organizations/peerOrganizations/middlemen.demo.com/peers/peer4.middlemen.demo.com/tls/server.crt"
  cp "${PWD}/organizations/peerOrganizations/middlemen.demo.com/peers/peer4.middlemen.demo.com/tls/keystore/"* "${PWD}/organizations/peerOrganizations/middlemen.demo.com/peers/peer4.middlemen.demo.com/tls/server.key"
  
infoln "Generating the user msp"
  set -x
  fabric-ca-client enroll -u https://user1:user1pw@localhost:8054 --caname ca-org2 -M "${PWD}/organizations/peerOrganizations/middlemen.demo.com/users/User1@middlemen.demo.com/msp" --tls.certfiles "${PWD}/organizations/fabric-ca/org2/ca-cert.pem"
 { set +x; } 2>/dev/null
 
 cp "${PWD}/organizations/peerOrganizations/middlemen.demo.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/middlemen.demo.com/users/User1@middlemen.demo.com/msp/config.yaml"

  infoln "Generating the org admin msp"
  set -x
  fabric-ca-client enroll -u https://org2admin:org2adminpw@localhost:8054 --caname ca-org2 -M "${PWD}/organizations/peerOrganizations/middlemen.demo.com/users/Admin@middlemen.demo.com/msp" --tls.certfiles "${PWD}/organizations/fabric-ca/org2/ca-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/organizations/peerOrganizations/middlemen.demo.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/middlemen.demo.com/users/Admin@middlemen.demo.com/msp/config.yaml"
