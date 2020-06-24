const Agency   = require('../../models/Agency'),
      IAgencyRepository = require('./iAgencyRepository');
      

class AgencyRepositoryMongoDb extends IAgencyRepository{

    constructor(){
        console.log('creating InStAnCe of RespositoryAgencyMongoDb');
        super();
    };

    // fetch all agencies without their subobjects
    async getAllAgencies() {
        let result;
        try{
            result = await Agency.find();
            return result;
        }catch(err){
            throw(err);
        }
    }

    // create a new agency
    async createAgency(agency) {
        let result;
        let myAgency = new Agency(
            {
                ...agence
            }
        );
        try{
            result = await myAgency.save();
            return result;
        }catch(err){
            throw(err);
        }
    }

    // fetch agency by its id with all its subobjects
    async getAgencyByIdWithAllItsSubObjects(id){
        let result;
        try{
            result = await Agency.findById(id)
                .populate(
                    {
                        path: 'employees',
                        model: 'Employee'
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

    // fetch agency by its id without its subobjects
    async getAgencyByIdWithoutItsSubObjects(id){
        let result;
        try{
            result = await Agency.findById(id);
            return result;
        }catch(err){
            throw(err);
        }
    }

    // make modification to the agency document
    async updateAgency(agencyId, modification){
        let result;
        try{
            result = await Agency.findByIdAndUpdate(agencyId, {$set: modification}, {new: true});
            return result;
        }catch(err){
            throw(err);
        }
    }
}

module.exports = AgencyRepositoryMongoDb;








