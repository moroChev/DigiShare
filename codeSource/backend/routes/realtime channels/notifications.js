const server = require('../../server');
const jwt    = require('jsonwebtoken');
const io     = require('socket.io')(server);


 class NotificationChannel{


     constructor(socketServer){
         this.io = socketServer;
     }

     notificationNameSpace(){
         return io.of('/employees');
     }

//     emitNotification(notification, socket){}

   onConnection = ()=>{
       this.notificationNameSpace.on('connection',(socket)=>{
           print("a user is connected ... his socket id is ..."+socket.id);
       });
   }


 }



module.exports = NotificationChannel; 