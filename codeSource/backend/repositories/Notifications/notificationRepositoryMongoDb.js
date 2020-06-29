const INotificationRepository = require('./iNotificationRepository');
const Notification            = require('../../models/Notification');
const util                    = require('util'); 

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

    async findWhere(object){
        try {
            let notifications = await Notification.find(object)
                                                   .populate([
                                                         {path:'notifier'},
                                                         {path:'publication'}
                                                        ],);
            
            return notifications;
        } catch (error) {
            console.log('eroro in find where');
            throw(error);
        }
    }

     /// creation of a new Notification
    async create(notification){
        try {
            let newNotification = await Notification.create(notification);
            return newNotification;
        } catch (error) {
            console.log('error in notif repo create notif');
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

     async updateMany(filter,modificationObject){
         try {
             let notifs = await Notification.updateMany(filter,{$set: modificationObject},{ safe: true, new: true});
             return notifs
         } catch (error) {
             throw(error);
         }
     }

}



module.exports = NotificationRepositoryMongoDb;