const Agency   = require('../../models/Agency'),
      Employee = require('../../models/Employee'),
      IRepositoryAgency = require('./IRepositoryAgencies'),
      util     = require('util');
      

class RespositoryAgencyMongoDb extends IRepositoryAgency{

    constructor(){
        console.log('creating InStAnCe of RespositoryAgencyMongoDb');
        super();
    };

    async getAgenciesWithEmployees() {

        let result;
        console.log("get Agencies with employees in agencyRepo MongoDB");
        try{
            result = await Agency.find()
                .populate(
                    {
                        path: 'employees',
                        model: 'Employee'
                    }
                );
                return result;
        }catch(err){
            throw(err);
        }
    }



    
async createAgency(agency) {
    let result;
    let myAgency = new Agency(
        {
            ...agence
        }
    );
    try{
        result = await myAgency.save();
    }catch(err){
        throw(err);
    }
    return result;
}

async getAgencyByIdWithEmployeesAndSubsidiaries(id){
    let result;
    try{
        result = await Agency.findById(id)
            .populate(
                {
                    path: 'employees',
                    populate : {
                        path : 'agency'
                    }
                }
            )
            .populate(
                {
                    path: 'subsidiaries',
                    model: 'Agency'
                }
            );
            return result;
    }catch(err){
        throw(err);
    }
}

async addEmployeeToAgency(employeeId, agencyId){

}

async addLocationToAgency(agencyId, location){
    let result;
    try{
        result = await Agency.findByIdAndUpdate(agencyId, { $set: {"location": location } }, { new: true });
        return result;
    }catch(err){
        throw(err);
    }
}










}

module.exports = RespositoryAgencyMongoDb;








