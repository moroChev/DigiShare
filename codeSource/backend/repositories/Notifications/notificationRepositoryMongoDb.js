const INotificationRepository = require('./iNotificationRepository');
const Notification            = require('../../models/Notification');

class NotificationRepositoryMongoDb extends INotificationRepository{

    constructor() {
        super();
    }

    async findById(id){
        try {
            let notification = await Notification.findById(id);
            return notification;
        } catch (error) {
            throw(error);
        }
    }

     /// creation of a new Notification
    async create(notification){
        try {
            let notification = await Notification.create(notification);
            return notification;
        } catch (error) {
            throw(error);
        }
    }
 
 
     /// find a notification by id and delete
    async findByIdAndDelete(id){
        try {
            let deletedNotif = await Notification.findByIdAndDelete(id);
            return deletedNotif;
        } catch (error) {
            throw(error);
        }
     }
 
     
     /// find by id and set isChecked
     /// it's dedicated to modify isChecked, object params in form : {isChecked : true || false }
    async findById_And_Set(id, object){
        try{
            let updatedNotif = await Notification.findByIdAndUpdate(id, {$set : object },{ safe: true, new: true});
            return updatedNotif;
        } catch (error) {
            console.log('error in set publication');
            throw(error);   
        }
     }

}



module.exports = NotificationRepositoryMongoDb;