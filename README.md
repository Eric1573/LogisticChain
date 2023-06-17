# LogisticChain
The logistics platform model based on hyperledger fabric blockchain, complete simulation of the entire international shipping process.
The smart contract structure of this program is modified by referring to the following project: https://github.com/kuldeep23907/Supply-Chain-using-Hyperledger-Fabric-and-React

LogisticChain facilitates the following functionalities:
1. Logistics participants undergo registration for identification purposes and are allocated distinct identifiers.
2. The consignor disseminates pertinent details concerning the merchandise within the LogisticChain platform.
3. The consignee initiates orders in accordance with the product information available in the system.
4. Middlemen (such as freight forwarders, shipping companies, and ports) assume responsibility for the conveyance and dissemination of goods.
5. All participants possess the ability to ascertain the logistics status at any given moment.


<div align=center><img width="532" height="320" src="https://github.com/Eric1573/LogisticChain/blob/main/IMG/Slide1.png"/></div>



 Organizations and Peer nodes：
 1. Consignor Organization (Peer nodes: Consignor)
 2. Middleman Organization (Peer nodes: Freight Forwarder, Export Port, Shipping company, Import Port, and Destination Freight Forwarder)
 3. Consignee Organization (Peer nodes: Consignee)

 Startup：./startnet.sh
 
 
 Operation process:
 1. Createuser:
1) peer chaincode  invoke -o localhost:9050 --ordererTLSHostnameOverride orderer.demo.com --tls --cafile "$ORDERER_CA" -C mychannel -n freight --peerAddresses localhost:8051 --tlsRootCertFiles "$PEER0_ORG3_CA" --peerAddresses localhost:7051 --tlsRootCertFiles "$PEER0_ORG2_CA"  -c '{"function":"createUser","Args":["Eric","111@pg.com","Consignor","Auckland","111222"]}'
2) peer chaincode  invoke -o localhost:9050 --ordererTLSHostnameOverride orderer.demo.com --tls --cafile "$ORDERER_CA" -C mychannel -n freight --peerAddresses localhost:8051 --tlsRootCertFiles "$PEER0_ORG3_CA" --peerAddresses localhost:7051 --tlsRootCertFiles "$PEER0_ORG2_CA"  -c '{"function":"createUser","Args":["Shirley","222@pg.com","FreightForwarder","Auckland2","111222"]}'
3) peer chaincode  invoke -o localhost:9050 --ordererTLSHostnameOverride orderer.demo.com --tls --cafile "$ORDERER_CA" -C mychannel -n freight --peerAddresses localhost:8051 --tlsRootCertFiles "$PEER0_ORG3_CA" --peerAddresses localhost:7051 --tlsRootCertFiles "$PEER0_ORG2_CA"  -c '{"function":"createUser","Args":["Jim","333@pg.com","ExportPort","Auckland3","111222"]}'
4) peer chaincode  invoke -o localhost:9050 --ordererTLSHostnameOverride orderer.demo.com --tls --cafile "$ORDERER_CA" -C mychannel -n freight --peerAddresses localhost:8051 --tlsRootCertFiles "$PEER0_ORG3_CA" --peerAddresses localhost:7051 --tlsRootCertFiles "$PEER0_ORG2_CA"  -c '{"function":"createUser","Args":["Author","444@pg.com","ShippingCompany","Auckland4","111222"]}'
5) peer chaincode  invoke -o localhost:9050 --ordererTLSHostnameOverride orderer.demo.com --tls --cafile "$ORDERER_CA" -C mychannel -n freight --peerAddresses localhost:8051 --tlsRootCertFiles "$PEER0_ORG3_CA" --peerAddresses localhost:7051 --tlsRootCertFiles "$PEER0_ORG2_CA"  -c '{"function":"createUser","Args":["Wang","555@pg.com","ImportPort","Shanghai1","111222"]}'
6) peer chaincode  invoke -o localhost:9050 --ordererTLSHostnameOverride orderer.demo.com --tls --cafile "$ORDERER_CA" -C mychannel -n freight --peerAddresses localhost:8051 --tlsRootCertFiles "$PEER0_ORG3_CA" --peerAddresses localhost:7051 --tlsRootCertFiles "$PEER0_ORG2_CA"  -c '{"function":"createUser","Args":["Zhang","666@pg.com","DestinationFreightForwarder","Shanghai2","111222"]}'
7)peer chaincode  invoke -o localhost:9050 --ordererTLSHostnameOverride orderer.demo.com --tls --cafile "$ORDERER_CA" -C mychannel -n freight --peerAddresses localhost:8051 --tlsRootCertFiles "$PEER0_ORG3_CA" --peerAddresses localhost:7051 --tlsRootCertFiles "$PEER0_ORG2_CA"  -c '{"function":"createUser","Args":["Lin","777@pg.com","Consignee","Shanghai3","111222"]}'

2. Consignor signin
1) peer chaincode  invoke -o localhost:9050 --ordererTLSHostnameOverride orderer.demo.com --tls --cafile "$ORDERER_CA" -C mychannel -n freight --peerAddresses localhost:8051 --tlsRootCertFiles "$PEER0_ORG3_CA" --peerAddresses localhost:7051 --tlsRootCertFiles "$PEER0_ORG2_CA"  -c '{"function":"signIn","Args":["User1","111222"]}'                         

3. Consignor createProduct
1) peer chaincode  invoke -o localhost:9050 --ordererTLSHostnameOverride orderer.demo.com --tls --cafile "$ORDERER_CA" -C mychannel -n freight --peerAddresses localhost:8051 --tlsRootCertFiles "$PEER0_ORG3_CA" --peerAddresses localhost:7051 --tlsRootCertFiles "$PEER0_ORG2_CA"  -c '{"function":"createProduct","Args":["tesla","User1","1000"]}'  
2) peer chaincode  invoke -o localhost:9050 --ordererTLSHostnameOverride orderer.demo.com --tls --cafile "$ORDERER_CA" -C mychannel -n freight --peerAddresses localhost:8051 --tlsRootCertFiles "$PEER0_ORG3_CA" --peerAddresses localhost:7051 --tlsRootCertFiles "$PEER0_ORG2_CA"  -c '{"function":"createProduct","Args":["BMW","User1","2000"]}'                    

4. Consignee order product
1) peer chaincode  invoke -o localhost:9050 --ordererTLSHostnameOverride orderer.demo.com --tls --cafile "$ORDERER_CA" -C mychannel -n freight --peerAddresses localhost:8051 --tlsRootCertFiles "$PEER0_ORG3_CA" --peerAddresses localhost:7051 --tlsRootCertFiles "$PEER0_ORG2_CA"  -c '{"function":"orderProduct","Args":["User7","Product1"]}'

5. Freight Forwarder receive product
1）peer chaincode  invoke -o localhost:9050 --ordererTLSHostnameOverride orderer.demo.com --tls --cafile "$ORDERER_CA" -C mychannel -n freight --peerAddresses localhost:8051 --tlsRootCertFiles "$PEER0_ORG3_CA" --peerAddresses localhost:7051 --tlsRootCertFiles "$PEER0_ORG2_CA"  -c '{"function":"sendToFreightForwarder","Args":["Product1","User2"]}'

6. Export port receive product
1）peer chaincode  invoke -o localhost:9050 --ordererTLSHostnameOverride orderer.demo.com --tls --cafile "$ORDERER_CA" -C mychannel -n freight --peerAddresses localhost:8051 --tlsRootCertFiles "$PEER0_ORG3_CA" --peerAddresses localhost:7051 --tlsRootCertFiles "$PEER0_ORG2_CA"  -c '{"function":"sendToExportPort","Args":["Product1","User3"]}'

7. Shipping Company receive product
1）peer chaincode  invoke -o localhost:9050 --ordererTLSHostnameOverride orderer.demo.com --tls --cafile "$ORDERER_CA" -C mychannel -n freight --peerAddresses localhost:8051 --tlsRootCertFiles "$PEER0_ORG3_CA" --peerAddresses localhost:7051 --tlsRootCertFiles "$PEER0_ORG2_CA"  -c '{"function":"sendToShippingCompany","Args":["Product1","User4"]}'

8. Import port receive product
1) peer chaincode  invoke -o localhost:9050 --ordererTLSHostnameOverride orderer.demo.com --tls --cafile "$ORDERER_CA" -C mychannel -n freight --peerAddresses localhost:8051 --tlsRootCertFiles "$PEER0_ORG3_CA" --peerAddresses localhost:7051 --tlsRootCertFiles "$PEER0_ORG2_CA"  -c '{"function":"sendToImportPort","Args":["Product1","User5"]}'

9. Destination Freight Forwarder receive product
1) peer chaincode  invoke -o localhost:9050 --ordererTLSHostnameOverride orderer.demo.com --tls --cafile "$ORDERER_CA" -C mychannel -n freight --peerAddresses localhost:8051 --tlsRootCertFiles "$PEER0_ORG3_CA" --peerAddresses localhost:7051 --tlsRootCertFiles "$PEER0_ORG2_CA"  -c '{"function":"sendToDestinationFreightForwarder","Args":["Product1","User6"]}'

10. Product delivered
1) peer chaincode  invoke -o localhost:9050 --ordererTLSHostnameOverride orderer.demo.com --tls --cafile "$ORDERER_CA" -C mychannel -n freight --peerAddresses localhost:8051 --tlsRootCertFiles "$PEER0_ORG3_CA" --peerAddresses localhost:7051 --tlsRootCertFiles "$PEER0_ORG2_CA"  -c '{"function":"sendToConsignee","Args":["Product1"]}'

11. Check product information
1) peer chaincode  invoke -o localhost:9050 --ordererTLSHostnameOverride orderer.demo.com --tls --cafile "$ORDERER_CA" -C mychannel -n freight --peerAddresses localhost:8051 --tlsRootCertFiles "$PEER0_ORG3_CA" --peerAddresses localhost:7051 --tlsRootCertFiles "$PEER0_ORG2_CA"  -c '{"function":"queryAsset","Args":["Product1"]}'
2) peer chaincode  invoke -o localhost:9050 --ordererTLSHostnameOverride orderer.demo.com --tls --cafile "$ORDERER_CA" -C mychannel -n freight --peerAddresses localhost:8051 --tlsRootCertFiles "$PEER0_ORG3_CA" --peerAddresses localhost:7051 --tlsRootCertFiles "$PEER0_ORG2_CA"  -c '{"function":"queryAsset","Args":["Product2"]}'

12. Check all users information
1) peer chaincode  invoke -o localhost:9050 --ordererTLSHostnameOverride orderer.demo.com --tls --cafile "$ORDERER_CA" -C mychannel -n freight --peerAddresses localhost:8051 --tlsRootCertFiles "$PEER0_ORG3_CA" --peerAddresses localhost:7051 --tlsRootCertFiles "$PEER0_ORG2_CA"  -c '{"function":"queryAll","Args":["User"]}'

Close project: ./stopnet.sh










 
