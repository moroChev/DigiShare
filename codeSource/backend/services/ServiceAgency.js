const util     = require('util');
//const agencyRepositoryMongo = require('../repositories/Agencies/RepositoryAgencyMongoDb');
class ServiceAgency{

    constructor(agencyRepo){
        console.log('creating InStAnCe of ServiceAgency');
        this.agencyRepo = agencyRepo;
    }

    // fetch all agencies with their employees
    async getAgenciesWithEmployees(){
        try{
            let result;
            result = await this.agencyRepo.getAgenciesWithEmployees(); 
            return result;                      
        }catch(err){
            throw(err);
        }
    }    

    // create a new agency
    async createAgency(agency){
        try{
            let result;
            result = await this.agencyRepo.createAgency(agency);
            return result;
        }catch(err){
            throw(err);
        }
    }

    // fetch agency by its id with all its subobjects
    async getAgencyByIdWithAllItsSubObjects(id){
        try{
            let result;
            result = await this.agencyRepo.getAgencyByIdWithAllItsSubObjects(id);
            return result;
        }catch(err){
            throw(err);
        }
    }

    // link the company with its agency
    async addAgencyToCompany(companyId, agencyId){
        try{
            let result;
            let company = await this.agencyRepo.getAgencyByIdWithoutItsSubObjects(companyId);
            let modification = {};
            modification.subsidiaries = company.subsidiaries;
            // first we ensure that we aren't going to link the company with itself 
            // and that the agency isn't already added to the company subsidiaries
            if(companyId != agencyId && company.subsidiaries.indexOf(agencyId) === -1){
                modification.subsidiaries.push(agencyId);
                result = await this.agencyRepo.updateAgency(companyId, modification);
                return result;
            }else
                return {"message": "agency already exists"};
        }catch(err){
            throw(err);
        }
    }

    // link the employee with its agency
    async addEmployeeToAgency(agencyId, employeeId){
        try{
            let result;
            let agency = await this.agencyRepo.getAgencyByIdWithoutItsSubObjects(agencyId);
            let modification = {};
            modification.employees = agency.employees;
            if(agency.employees.indexOf(employeeId) === -1){
                modification.employees.push(employeeId);
                result = await this.agencyRepo.updateAgency(agencyId, modification);
                return result;
            }else
                return {"message": "employee already exists"};
        }catch(err){
            throw(err);
        }
    }

    // initialize the agency's location
    async addLocationToAgency(agencyId, lat, lng){
        try{
            let result;
            let modification = {};
            modification.location = {};
            modification.location.lat = lat;
            modification.location.lng = lng;
            result = await this.agencyRepo.updateAgency(agencyId, modification);
            return result;
        }catch(err){
            throw(err);
        }
    }

}

module.exports = ServiceAgency;