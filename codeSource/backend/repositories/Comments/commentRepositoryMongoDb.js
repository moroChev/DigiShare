const Comment = require('../../models/Comment');
const ICommentRepository = require('./iCommentRepository');

class CommentRepositoryMongoDb extends ICommentRepository{

    constructor(){
        super();
    }

   /// creation of a new comment
   async create(object){
       try {
           console.log("creation of a new comment"+object);
           let comment = await Comment.create(object);
           return comment;
       } catch (error) {
           throw(error);
       }
   }


   /// find a comment by id
   async findById(id){
       try {
           let comment = await Comment.findById(id);
           return comment;
       } catch (error) {
           throw(error);
       }
   }


   /// find comments where their fields satisfied that object
   async findWhere(object){
       try {
           console.log("FindWhere : "+object);
           let comment = await Comment.find(object).populate({ path: 'commentator', populate : { path : 'agency' } });
           return comment;
       } catch (error) {
           throw(error);
       }
   }


   /// find all documents which they passn't the fliter 
   /// and and update them with the Modification boject
   async updateMany(filter,modificationObject){}


   /// find a comment by id and delete
   async findByIdAndDelete(id){
    try {
        let deletedOne = await Comment.findByIdAndDelete(id);
        return deletedOne; 
    } catch (error) {
        console.log("error in suppression comment repos");
        throw(error)
    }
   }

   
   
   async findById_And_Set(id, object){
       try {
           let comment = await Comment.findByIdAndUpdate(id, {$set : object },{ safe: true, new: true});
           return comment;
       } catch (error) {
           throw(error);
       }
   }





}


module.exports = CommentRepositoryMongoDb; 