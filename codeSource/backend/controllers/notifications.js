const globalUtils = require('../utility/globalUtil');

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

    getEmployeeNotifications = async (req,res,next)=>{
        try {
            let userId = globalUtils.returnUserIdFromHeader(req);
            let notifications = await this._notifService.getEmployeeNotifications(userId);
            res.status(200).json(notifications);
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
            let notifiedUsers = await this._notifService.newPublicationNotification(publication);
            notifiedUsers.notified.forEach(employee => this.notifyOnUserConnected(employee));
        } catch (error) {
            console.log('error in cTrl notif newPublicationNotif')
            throw(error);
        }
    }

    approvalPublicationNotif(publication){

    }


    notifyOnUserConnected(employee){
        console.log('i want to send a notification to '+employee._id)
        if(this._socketRepo.userMap.has(employee._id)){
            console.log(employee._id+"gonna receive it now ..");
         //   this.sendNotificationToConnectedSocket(this.userMap.get(`${employee._id}`));
        }
    }


    sendNotificationToConnectedSocket(to_user_socket_id, notification) {
        console.log('i am sending the notification to the connected user ...');
		this._socket.to(`${to_user_socket_id}`).emit('notification', this.stringifyToJson(notification));
	}

}


module.exports=NotificationController;