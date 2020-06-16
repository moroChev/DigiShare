const util     = require('util');
//const agencyRepositoryMongo = require('../repositories/Agencies/RepositoryAgencyMongoDb');
class ServiceAgency{


    
    constructor(agencyRepo){
        console.log('creating InStAnCe of ServiceAgency');
        this.agencyRepo = agencyRepo;
    }

    async getAgenciesWithEmployees(){
        let result;
        console.log("get Agencies with employees in ServiceAgency");
        try{
            result = await this.agencyRepo.getAgenciesWithEmployees(); 
            return result;                      
        }catch(err){
            throw(err);
        }
    }

    

    async createAgency(agency){
        let result;
        try{
            result = await this.agencyRepo.createAgency(agency);
            return result;
        }catch(err){
            throw(err);
        }
    }

    async getAgencyByIdWithEmployeesAndSubsidiaries(id){
        let result;
        try{
            result = await this.agencyRepo.getAgencyByIdWithEmployeesAndSubsidiaries(id);
            return result;
        }catch(err){
            throw(err);
        }
    }

    async addLocationToAgency(agencyId, location){
        let result;
        try{
            result = await this.agencyRepo.addLocationToAgency(agencyId, location);
            return result;
        }catch(err){
            throw(err);
        }
    }

}

module.exports = ServiceAgency;