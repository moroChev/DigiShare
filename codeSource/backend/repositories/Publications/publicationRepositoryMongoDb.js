const IPublicationRepository = require("./IPublicationRepository");
const Publication            = require("../../models/Publication");

class PublicationRepositoryMongoDb extends IPublicationRepository{

    constructor(){
        super();
    }

    /// getting all the publications with employees agencies
    async find_And_Employees_Agencies(){
        console.log("repository pub");
        try {
            let publications;
                publications = await Publication.find() 
                                                .populate(
                                                [
                                                    { path: 'approvedBy', populate : { path : 'agency' } },
                                                    { path: 'postedBy', populate : { path : 'agency' } }
                                                ]
                                                );
            return publications;
        } catch (error) {
            console.log('error in repo');
            throw(error);
        }
    }


}


module.exports = PublicationRepositoryMongoDb;