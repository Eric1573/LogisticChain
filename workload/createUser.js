'use strict';

const { WorkloadModuleInterface } = require('@hyperledger/caliper-core');

class CreateUserWorkload extends WorkloadModuleInterface {
    constructor() {
        super();
        this.workerIndex = -1;
        this.totalWorkers = -1;
        this.roundIndex = -1;
        this.roundArguments = undefined;
        this.sutAdapter = undefined;
        this.sutContext = undefined;
    }
async initializeWorkloadModule(workerIndex, totalWorkers, roundIndex, roundArguments, sutAdapter, sutContext) {
        
this.workerIndex = workerIndex;
        this.totalWorkers = totalWorkers;
        this.roundIndex = roundIndex;
        this.roundArguments = roundArguments;
        this.sutAdapter = sutAdapter;
        this.sutContext = sutContext;
        
    }

  

    async submitTransaction() {
        let requestSettings = {
            contractId: 'freight',
            contractVersion: '1.0',
            contractFunction: 'createUser', //修改
            contractArguments: ["Eric","112233@abc","Consignor","shanghai","111222"],  //相应参数
            invokerIdentity: 'admin.consignor.demo.com',  
            timeout: 30
        };
        await this.sutAdapter.sendRequests(requestSettings);

    }

    async cleanupWorkloadModule() {
        // NOOP
    }
}

function createWorkloadModule() {
    return new CreateUserWorkload();
}

module.exports.createWorkloadModule = createWorkloadModule;
