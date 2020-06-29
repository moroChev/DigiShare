const notifType = require('../utility/notificationType');
const util      = require('util');


class NotificationService{

    constructor(notifRepo,employeeRepo) {
        this._notificationRepo = notifRepo;
        this._employeeRepo = employeeRepo;
        console.log('Notification Service !');
    }

    /** 
     * take a new publication, try to create new notif
     * add the notif to the list of the notif list that belong to the employees who can approve the publication 
     * 
     */
   async newPublicationNotification(publication){
        try {
            let notifObject = {
                'notificationType': notifType.NEW_PUBLICATION,
                'notifier': publication.postedBy,
                'publication': publication._id
            }
            let employees = await this.selectWhoCanApprove(notifObject.notifier); 
            employees.forEach(async employee=> await this.createNotifForAnEmployee(employee,notifObject));
            console.log(util.inspect(notifObject));
            let notifAndNotified = {
                'notification': notifObject,
                'notified':employees
            }
            return notifAndNotified;
        } catch (error) {
            console.log("error in newPublicationNotification");
            throw(error);
        }
    };

    async selectWhoCanApprove(notifierId) {
        try {
            let notifier = await this._employeeRepo.findById(notifierId);
            let employees = await this._employeeRepo.findWhere({"canApprove":true, "agency":notifier.agency._id});
            console.log("selecting who can Approve is okay");
            return employees;
        } catch (error) {
            console.log("error in selectWhoCanApprove");
            throw(error);
        }
    }
    async createNotifForAnEmployee(employee,notif){
        try {
            console.log("creat notif for employee"+employee.lastName);
            notif.notified = employee._id;
            console.log("just before saving the notif"+util.inspect(notif));
            let notification = await this._notificationRepo.create(notif);
            console.log(util.inspect(notification));
        } catch (error) {
            console.log("error in createNotif for an employee");
            throw(error);
        }
    }

    async getEmployeeNotifications(id){
        try {
            let notifications = await this._notificationRepo.findWhere({'notified':id});
            return notifications.sort((notifA,notifB)=>  notifB.date - notifA.date );
        } catch (error) {
            console.log('errror employe Service finding notifs');
            throw(error);
        }
    }

    async putAllNotifsAsSeen(userId){
        try {
            let notifs = await this._notificationRepo.updateMany({"isSeen":false,"notified":userId},{"isSeen":true});
            return notifs;
        } catch (error) {
            throw(error);
        }

    }

    async putNotifAsChecked(id){
        try {
            let notifs = await this._notificationRepo.findById_And_Set(id,{"isChecked":true});
            return notifs;
        } catch (error) {
            throw(error);
        }
 
    }

}

module.exports = NotificationService; 