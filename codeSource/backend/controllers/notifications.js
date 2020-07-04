const globalUtils = require('../utility/globalUtil');
const util = require('util');
const { json } = require('body-parser');

class NotificationController{

    constructor(notifcationService,socketRepo){
        this._notifService = notifcationService;
        this._socketRepo = socketRepo;
        console.log('Notification Controller !');
    }

    setSocket(socket){
        this._socket=socket;
        console.log('i set the socket with success ..');
    }

    setSocketIOServer(io){
        this._io = io;
    }

    getEmployeeNotifications = async (req,res,next)=>{
        try {
            let userId = globalUtils.returnUserIdFromHeader(req);
            let notifications = await this._notifService.getEmployeeNotifications(userId);
            res.status(200).json(notifications);
        } catch (error) {
            res.status(500).json(error);
        }
    }

    deleteNotification = async (req,res,next)=>{
        try {
            let result = await this._notifService.deleteNotification(req.params.id);
            res.status(200).json({'message':true});
        } catch (error) {
            res.status(500).json(error);
        }
    }

    putAllNotificationsAsSeen = async (req,res,next)=>{
        try{
            let userId = globalUtils.returnUserIdFromHeader(req);
            let notifs = this._notifService.putAllNotifsAsSeen(userId);
            res.status(200).json({'withSuccess':true});
        } catch (error) {
            res.status(500).json(error);
        }
    }

    putNotificationAsChecked = async (req,res,next)=>{
        try {
            let notif = this._notifService.putNotifAsChecked(req.params.id);
            res.status(200).json({'withSuccess':true});
        } catch (error) {
            res.status(500).json(error);
        }
    }


   async newPublicationNotif(publication){
        try {
            let notifsAndUsers = await this._notifService.newPublicationNotification(publication);
            notifsAndUsers.forEach(notifAndUser => this.notifyOnUserConnected(notifAndUser));
        } catch (error) {
            console.log('error in cTrl notif newPublicationNotif')
            throw(error);
        }
    }

   async approvalPublicationNotif(publication){
        try {
            let notifAndUser = await this._notifService.approvalPublicationNotif(publication);
            this.notifyOnUserConnected(notifAndUser);
        } catch (error) {
            console.log('error in cTrl notif approvalPublicationNotif')
            throw(error);
        }
    }

    async likePublicationNotif(publication,likerId){
        try {
            let notifAndUser = await this._notifService.likePublicationNotif(publication,likerId);
            this.notifyOnUserConnected(notifAndUser);
        } catch (error) {
            throw(error);
        }

    }

    async commentPublicationNotif(publication,commentatorId){
        try {
            let notifAndUser = await this._notifService.commentPublicationNotif(publication,commentatorId);
            this.notifyOnUserConnected(notifAndUser);
        } catch (error) {
            throw(error);
        }
    }


  notifyOnUserConnected(notifAndUser){
        let userId = notifAndUser.notified._id.toString();
        let myNotif = notifAndUser.notification;
        let isUserConnected = this._socketRepo.userMap.has(userId);
        if(isUserConnected){
                console.log(userId+"gonna receive it now .. "+myNotif);
                this.sendNotificationToConnectedSocket(this._socketRepo.userMap.get(userId),myNotif);
        }
        else{
                console.log('userNot connected');
        }
    }


    sendNotificationToConnectedSocket(to_user_socket_id, notification) {
        let socketId= to_user_socket_id.socket_id.toString();
        let notifStrinfied = JSON.stringify(notification);
        console.log('i am sending the notification to the connected user ... now socketid is : '+socketId);
		this._io.to(socketId).emit('notification', notifStrinfied);
	}

}


module.exports=NotificationController;