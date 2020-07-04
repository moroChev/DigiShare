class ICommentRepository{

    constructor(){}

     /// creation of a new comment
     create(object){}


     /// find a comment by id
     findById(id){}
 
 
     /// find comments where their fields satisfied that object
     findWhere(object){}
 
 
     /// find all documents which they passn't the fliter 
     /// and and update them with the Modification boject
     updateMany(filter,modificationObject){}
 
 
     /// find a comment by id and delete
     findByIdAndDelete(id){}
 
     
     
     findById_And_Set(id, object){}




}

module.exports = ICommentRepository;