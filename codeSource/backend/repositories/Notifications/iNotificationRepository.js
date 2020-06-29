class INotificationRepository{


    constructor(){}

    
    /// creation of a new Notification
    create(object){}


    /// find a notifcation by id
    findById(id){}


    /// find notifications where their fields satisfied that object
    findWhere(object){}


    /// find all documents which they passn't the fliter 
    /// and and update them with the Modification boject
    updateMany(filter,modificationObject){}


    /// find a notification by id and delete
    findByIdAndDelete(id){}

    
    /// find by id and set isChecked
    /// it's dedicated to modify isChecked,
    /// object params in form : {isChecked : true || false }
    findById_And_Set(id, object){}


}


module.exports = INotificationRepository;