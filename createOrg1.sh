#!/bin/bash
. scripts/utils.sh
infoln "Creating Org1 Identities Enrolling the CA admin"
mkdir -p organizations/peerOrganizations/consignor.demo.com/
export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/peerOrganizations/consignor.demo.com/
set -x
fabric-ca-client enroll -u https://admin:adminpw@localhost:7054 --caname ca-org1 --tls.certfiles "${PWD}/organizations/fabric-ca/org1/ca-cert.pem"
{ set +x; } 2>/dev/null

echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-org1.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-org1.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-org1.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-org1.pem
    OrganizationalUnitIdentifier: orderer' > "${PWD}/organizations/peerOrganizations/consignor.demo.com/msp/config.yaml"

mkdir -p "${PWD}/organizations/peerOrganizations/consignor.demo.com/msp/tlscacerts"
cp "${PWD}/organizations/fabric-ca/org1/ca-cert.pem" "${PWD}/organizations/peerOrganizations/consignor.demo.com/msp/tlscacerts/ca.crt"
mkdir -p "${PWD}/organizations/peerOrganizations/consignor.demo.com/tlsca"
cp "${PWD}/organizations/fabric-ca/org1/ca-cert.pem" "${PWD}/organizations/peerOrganizations/consignor.demo.com/tlsca/tlsca.consignor.demo.com-cert.pem"

mkdir -p "${PWD}/organizations/peerOrganizations/consignor.demo.com/ca"
cp "${PWD}/organizations/fabric-ca/org1/ca-cert.pem" "${PWD}/organizations/peerOrganizations/consignor.demo.com/ca/ca.consignor.demo.com-cert.pem"

fabric-ca-client register --caname ca-org1 --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles "${PWD}/organizations/fabric-ca/org1/ca-cert.pem"
fabric-ca-client register --caname ca-org1 --id.name user1 --id.secret user1pw --id.type client --tls.certfiles "${PWD}/organizations/fabric-ca/org1/ca-cert.pem"
fabric-ca-client register --caname ca-org1 --id.name org1admin --id.secret org1adminpw --id.type admin --tls.certfiles "${PWD}/organizations/fabric-ca/org1/ca-cert.pem"
# Register Identity
fabric-ca-client enroll -u https://peer0:peer0pw@localhost:7054 --caname ca-org1 -M "${PWD}/organizations/peerOrganizations/consignor.demo.com/peers/peer0.consignor.demo.com/msp" --csr.hosts peer0.consignor.demo.com --tls.certfiles "${PWD}/organizations/fabric-ca/org1/ca-cert.pem"

cp "${PWD}/organizations/peerOrganizations/consignor.demo.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/consignor.demo.com/peers/peer0.consignor.demo.com/msp/config.yaml"

fabric-ca-client enroll -u https://peer0:peer0pw@localhost:7054 --caname ca-org1 -M "${PWD}/organizations/peerOrganizations/consignor.demo.com/peers/peer0.consignor.demo.com/tls" --enrollment.profile tls --csr.hosts peer0.consignor.demo.com --csr.hosts localhost --tls.certfiles "${PWD}/organizations/fabric-ca/org1/ca-cert.pem"
cp "${PWD}/organizations/peerOrganizations/consignor.demo.com/peers/peer0.consignor.demo.com/tls/tlscacerts/"* "${PWD}/organizations/peerOrganizations/consignor.demo.com/peers/peer0.consignor.demo.com/tls/ca.crt"
cp "${PWD}/organizations/peerOrganizations/consignor.demo.com/peers/peer0.consignor.demo.com/tls/signcerts/"* "${PWD}/organizations/peerOrganizations/consignor.demo.com/peers/peer0.consignor.demo.com/tls/server.crt"
cp "${PWD}/organizations/peerOrganizations/consignor.demo.com/peers/peer0.consignor.demo.com/tls/keystore/"* "${PWD}/organizations/peerOrganizations/consignor.demo.com/peers/peer0.consignor.demo.com/tls/server.key"
fabric-ca-client enroll -u https://user1:user1pw@localhost:7054 --caname ca-org1 -M "${PWD}/organizations/peerOrganizations/consignor.demo.com/users/User1@consignor.demo.com/msp" --tls.certfiles "${PWD}/organizations/fabric-ca/org1/ca-cert.pem"
cp "${PWD}/organizations/peerOrganizations/consignor.demo.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/consignor.demo.com/users/User1@consignor.demo.com/msp/config.yaml"
fabric-ca-client enroll -u https://org1admin:org1adminpw@localhost:7054 --caname ca-org1 -M "${PWD}/organizations/peerOrganizations/consignor.demo.com/users/Admin@consignor.demo.com/msp" --tls.certfiles "${PWD}/organizations/fabric-ca/org1/ca-cert.pem"
cp "${PWD}/organizations/peerOrganizations/consignor.demo.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/consignor.demo.com/users/Admin@consignor.demo.com/msp/config.yaml"
