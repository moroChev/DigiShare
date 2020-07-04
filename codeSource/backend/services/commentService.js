const util = require('util');
const pubUtil = require('../utility/publicationUtils');
const notifTypes = require('../utility/notificationType');

class CommentService{

    constructor(commentRepo,publicationRepo,notifCtrl){
     this._publicationRepo = publicationRepo; 
     this._commentRepo = commentRepo;   
     this._notificationController = notifCtrl; 
    }

    async getAllComments(publicationId){
        try {
            let comments = await this._commentRepo.findWhere({"publication":publicationId});
            return comments;
        } catch (error) {
            throw(error);
        }

    }

    async addComment(publicationId,commentObject){
        try {
            commentObject.publication = publicationId;
            console.log("Comment Service"+util.inspect(commentObject));
            let comment = await this._commentRepo.create(commentObject);
            let publication = await this._publicationRepo.findById_And_AddToSet(publicationId,{ "comments" : comment._id });
            await this.notifyObservers(publication,notifTypes.COMMENT,commentObject.commentator);
            return comment;
        } catch (error) {
            throw(error);
        }
    }

    async editComment(commentId,commentObject){
        try {
            let comment = await this._commentRepo.findById_And_Set(commentId, commentObject);
            return comment;
        } catch (error) {
            throw(error);
        }
    }

    async deleteComment(commentId){
        try {
            let comment = await this._commentRepo.findByIdAndDelete(commentId);
            let publication = await this._publicationRepo.findById_And_Pull(id, { "comments" : comment._id });
            return comment;
        } catch (error) {
            throw(error);
        } 
    }


    async notifyObservers(publication,notifType, notifierId){
        try{
            if(notifType==notifTypes.COMMENT){
                 await this._notificationController.commentPublicationNotif(publication,notifierId);
             }
         }catch(error){
             throw(error);
         }
    }
}

module.exports = CommentService;