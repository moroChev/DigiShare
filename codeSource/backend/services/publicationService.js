const util = require('util');
const fs   = require('fs');

class PublicationService{

    constructor(publicationRepo, employeeRepo){
     this._publicationRepo = publicationRepo;
     this._employeeRepo   = employeeRepo;  
    }

    async getPublicationById(id){
        try {
            console.log("in servcie .... "+id);
            let pub = await this._publicationRepo.findById(id);
            return pub;
        } catch (error) {
            throw(error);
        }
    }

    async getAllPublications(){
        console.log("Service pub");
        try {
            let publications;
            publications = await this._publicationRepo.find_And_Employees_Agencies();
            /// sorting the publications by date
            let publicationsSortedByDate = publications.sort((pubA,pubB)=>  pubB.date - pubA.date )
            return publicationsSortedByDate;
        } catch (error) {
            console.log('error in service');
            throw(error);
        }
    }


    async createPublication(publication){
        console.log("Service creation post !"+publication);
        try {
            let newPost  = await this._publicationRepo.create(publication);
            let employee = await this._employeeRepo.findById_And_AddToSet(newPost.postedBy, { "publications": newPost._id });
            console.log("created Post and new one is "+newPost);
            return {"publication": newPost, "postedBy": employee};
        } catch (error) {
            console.log('error in service create Publication');
            throw(error);
        }
    }


    async deletePublication(id){
        try {
            let deletedOne = await this._publicationRepo.findByIdAndDelete(id);
            const fileName =  deletedOne.imageUrl.split('/postsImages/')[1];
            fs.unlink(`images/postsImages/${fileName}`,(err)=>{console.log('error in deleting the image');});
            let employee = await this._employeeRepo.findById_And_Pull(deletedOne.postedBy, { "publications" : id });
            return {'employee': employee};
        } catch (error) {
            console.log("error in suppr service publ");
            throw(error)
        }
    }

    
    async modifyPublication(id,publicationP){
        try {
            console.log(util.inspect(publicationP));
            let publication = this._publicationRepo.findById_And_Set(id,publicationP);
            return publication;
        } catch (error) {
            throw(error);
        }
     }


    async addlikePublication(id,employeeId){ 
        try {
            let publication = await this._publicationRepo.findById_And_AddToSet(id,{ "likes" : employeeId });
            return publication;
        } catch (error) {
            throw(error)
        }
    }

   async removeLikePublication(id,employeeId){
       try {
           console.log(employeeId);
           let publication = await this._publicationRepo.findById_And_Pull(id, { "likes" : employeeId });
           return publication;
       } catch (error) {
           throw(error);
       }
    }

   async getPublicationLikes(id){
       try {
           let publication = await this._publicationRepo.findById_AllLikers_Agencies(id);
           return publication;
       } catch (error) {
           throw(error);
       }
    }


   async approvePublication(id,employeeId, isApproved){ 
       try {
           let approval = { 
               isApproved: isApproved,
                approvedBy: employeeId 
            }
           let publication = await this._publicationRepo.findById_And_Set(id,approval);
           return publication;
       } catch (error) {
           throw(error);
       }
   }

}

module.exports = PublicationService;