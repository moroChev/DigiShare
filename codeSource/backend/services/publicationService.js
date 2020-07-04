const util = require('util');
const pubUtil = require('../utility/publicationUtils');
const notifTypes = require('../utility/notificationType');
const globalUtil = require('../utility/globalUtil');

class PublicationService{

    constructor(publicationRepo, employeeRepo,notifCtrl){
     this._publicationRepo = publicationRepo;
     this._employeeRepo   = employeeRepo;
     this._notificationController = notifCtrl; 
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
            publications = await this._publicationRepo.find_And_Employees_Agencies({"isApproved":true});
            /// sorting the publications by date
            let publicationsSortedByDate = publications.sort((pubA,pubB)=>  pubB.date - pubA.date );
            return publicationsSortedByDate;
        } catch (error) {
            console.log('error in service');
            throw(error);
        }
    }


    async createPublication(publication){
        console.log("Service creation post !"+util.inspect(publication));
        try {
            let newPost  = await this._publicationRepo.create(publication);
            let employee = await this._employeeRepo.findById_And_AddToSet(newPost.postedBy, { "publications": newPost._id });
            await this.notifyObservers(newPost,notifTypes.NEW_PUBLICATION);
            return {"publication": newPost, "postedBy": employee};
        } catch (error) {
            console.log('error in service create Publication');
            throw(error);
        }
    }


    async deletePublication(id){
        try {
            let deletedOne = await this._publicationRepo.findByIdAndDelete(id);
            pubUtil.removePostImage(deletedOne.imageUrl);
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
            await this.notifyObservers(publication,notifTypes.LIKE,employeeId);
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
            console.log(util.inspect(approval));
           let publication = await this._publicationRepo.findById_And_Set(id,approval);
           await this.notifyObservers(publication,notifTypes.APPROVAL);
           return publication;
       } catch (error) {
           throw(error);
       }
   }

   async notifyObservers(publication,notifType, notifierId){
       try{
           if(notifType==notifTypes.NEW_PUBLICATION){
                await this._notificationController.newPublicationNotif(publication);
            }else if(notifType==notifTypes.APPROVAL){
                await this._notificationController.approvalPublicationNotif(publication);
            }else if(notifType==notifTypes.LIKE){
                await this._notificationController.likePublicationNotif(publication,notifierId);
            }
        }catch(error){
            throw(error);
        }
   }

}

module.exports = PublicationService;