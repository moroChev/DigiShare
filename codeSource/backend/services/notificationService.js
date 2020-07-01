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
            let listNotifsUsers = await this.createNotifForListEmps(employees,notifObject);   
            return listNotifsUsers;
        } catch (error) {
            console.log("error in newPublicationNotification");
            throw(error);
        }
    };

    async approvalPublicationNotif(publication){
        try {
            let notifObject = {
                'notificationType': notifType.APPROVAL,
                'notifier': publication.approvedBy,
                'publication': publication._id
            }
            let notified = await this._employeeRepo.findById(publication.postedBy);
            let notifAndNotified = await this.createNotifForAnEmployee(notified,notifObject);
            notifAndNotified.notifier=publication.approvedBy
            return notifAndNotified;
        } catch (error) {
            console.log("error in approvalNotification");
            throw(error);
        }
    }

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

    async createNotifForListEmps(employees,notifObject){
        let notifsAndUsers = [];
        for(var i=0; i<employees.length; i++){
            let myNotif = await this.createNotifForAnEmployee(employees[i],notifObject);
            notifsAndUsers.push(myNotif);
        }
        return notifsAndUsers;
    }


    async createNotifForAnEmployee(employee,notif){
        try {
            notif.notified = employee._id;
            let notification = await this._notificationRepo.create(notif);
            let notifAndUser = {
                'notification': notification,
                'notified':employee
            }
            console.log(notifAndUser);
            return notifAndUser;
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

    async deleteNotification(id){
        try {
            let notif = await this._notificationRepo.findByIdAndDelete(id);
            return notif != null ? true : false;
        } catch (error) {
            throw(error);
        }
    }

}

module.exports = NotificationService; 