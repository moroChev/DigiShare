const PublicationRepositoryMongoDb = require('../repositories/Publications/publicationRepositoryMongoDb');

class PublicationService{

    constructor(){
     this.pulicationRepo = new PublicationRepositoryMongoDb(); 
    }


    async getAllPublications(){
        console.log("Service pub");
        try {
            let publications;
            publications = await this.pulicationRepo.find_And_Employees_Agencies();
            /// sorting the publications by date
            let publicationsSortedByDate = publications.sort((pubA,pubB)=>  pubB.date - pubA.date )
            return publicationsSortedByDate;
        } catch (error) {
            console.log('error in service');
            throw(error);
        }
    }





}

module.exports = PublicationService;