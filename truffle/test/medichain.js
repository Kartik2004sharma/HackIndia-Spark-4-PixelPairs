const MediChain = artifacts.require("MediChain");

require('chai')
    .use(require('chai-as-promised'))
    .should()

contract('MediChain', ([deployer, patientOne, patientTwo, doctorOne, doctorTwo, insurerOne, insurerTwo]) => {
    let mediChain

    before(async () => {
        mediChain = await MediChain.deployed()
    })

    describe('deployment', async () => {
        it('deploys successfully', async () => {
            const address = await mediChain.address
            assert.notEqual(address, 0x0)
            assert.notEqual(address, '')
            assert.notEqual(address, null)
            assert.notEqual(address, undefined)
        })
    
        it('has a name', async () => {
            const name = await mediChain.name()
            assert.equal(name, 'mediChain')
        })
    })

    describe('patients', async () => {
        let result
        const name = "Sam"
        const age = 22
        const email = "sam@example.com"
        const hash = "QmV8cfu6n4NT5xRr2AHdKxFMTZEJrA44qgrBCr739BN9Wb"

        before(async () => {
            // Replacing add_agent with register, and providing correct arguments
            result = await mediChain.register(name, age, 1, email, hash, { from: patientOne })
        })

        it('adds patients', async () => {
            const patient = await mediChain.patientInfo(patientOne)
            assert.equal(patient.name, name, 'patient name is correct')
            assert.equal(patient.email, email, 'patient email is correct')
            assert.equal(patient.age, age, 'patient age is correct')
            assert.equal(patient.record, hash, 'patient record hash is correct')
        })
    })

});