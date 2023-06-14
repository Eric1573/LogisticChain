'use strict';

const { WorkloadModuleBase } = require('@hyperledger/caliper-core');

const prices=["25","45","86","120","34","98","45"]
const names=["drink","iphone","computer","clothes","ball","software","toy","game"]
const users=["User1","User2","User3","User4","User5","User6","User7","User8"]
class CreateProductWorkload extends WorkloadModuleBase{
    constructor() {
        super();
        this.txIndex = 0;
    }
    

  

    async submitTransaction() {
        this.txIndex++;
        let productId='Client' + this.workerIndex + '_PRODUCT' + this.txIndex.toString();
        let price=prices[Math.floor(Math.random() * prices.length)]
        let name=names[Math.floor(Math.random() * names.length)]
        let user=users[Math.floor(Math.random() * users.length)]
        let requestSettings = {
            contractId: 'freight',
            contractVersion: '1.0',
            contractFunction: 'createProduct',
            contractArguments: [productId,name,"User1",price],
            // invokerIdentity: 'admin.consignor.demo.com',
            timeout: 60
        };
        
        await this.sutAdapter.sendRequests(requestSettings);

    }

    async cleanupWorkloadModule() {
        // NOOP
    }
}

function createWorkloadModule() {
    return new CreateProductWorkload();
}

module.exports.createWorkloadModule = createWorkloadModule;
