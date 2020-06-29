const socketConsts = require('./socket_consts');

class SocketController{
	constructor(messageSrv, socketServices, socketRepo){
		console.log('creating InStAnCe of SocketController');
		this.messageSrv = messageSrv;
		this.socketServices = socketServices;
		this.socketRepo = socketRepo;
	}

	async singleChatHandler(socket, chat_message){
		console.log('onMessage: ' + this.socketServices.stringifyToJson(chat_message));
		let to_user_id = chat_message.to;
		let from_user_id = chat_message.from;
		console.log(from_user_id + ' => ' + to_user_id);
		// initialy mark the message as sent
		chat_message.status = socketConsts.STATUS_MASSAGE_SENT;
		let to_user_socket_id = this.socketRepo.getSocketIDFromMapForThisUser(to_user_id);
		if(undefined == to_user_socket_id){
			console.log('Chat User not Connected');
			chat_message.to_user_online_status = false;
			//stock the msg and send socket
			let msg = await this.messageSrv.addMessageToRoom(chat_message);
			if(!msg){
				// if failed adding the message to database mark it as not sent
				chat_message.status = socketConsts.STATUS_MASSAGE_NOT_SENT;
			}
			// send back to client: msg status has changed
			this.socketServices.sendBackToClient(socket, socketConsts.SUB_EVENT_MESSAGE_STATUS_CHANGED, chat_message);
		}else{
			console.log('Chat User is Connected');
			chat_message.to_user_online_status = true;
			// before adding the msg to the database
			// we have target user is connected so we matk the msg as delivered
			chat_message.status = socketConsts.STATUS_MASSAGE_DELIVERED;
			//stock the msg and send socket
			let msg = await this.messageSrv.addMessageToRoom(chat_message);
			if(msg){
				this.socketServices.sendToConnectedSocket(socket, to_user_socket_id, socketConsts.SUB_EVENT_RECEIVE_MESSAGE, msg);
				this.socketServices.sendBackToClient(socket, socketConsts.SUB_EVENT_MESSAGE_STATUS_CHANGED, msg);
			}
			else{
				// if failed adding the message to database mark it as not sent
				chat_message.status = socketConsts.STATUS_MASSAGE_NOT_SENT;
				this.socketServices.sendBackToClient(socket, socketConsts.SUB_EVENT_MESSAGE_STATUS_CHANGED, chat_message);
			}
		}
	}

	async messageSeenHandler(socket, chat_message){
		console.log('onMessageSeen: ' + this.socketServices.stringifyToJson(chat_message));
		// updating msg in the database
		let msg = await this.messageSrv.updateMessage(chat_message);
		// getting fromUser's socketId
		let from_user_id = chat_message.from;
		let from_user_socket_id = this.socketRepo.getSocketIDFromMapForThisUser(from_user_id);
		if(undefined == from_user_socket_id){
			console.log('Chat User not Connected');
			return;
		}else{
			console.log('Chat User is Connected');
			if(msg){
				this.socketServices.sendToConnectedSocket(socket, from_user_socket_id, socketConsts.SUB_EVENT_MESSAGE_STATUS_CHANGED, msg);
			}
		}
	}

	onlineCheckHandler(socket, chat_user_details){
		let to_user_id = chat_user_details.to;
		console.log('Checking Online User => ' + to_user_id);
		let to_user_socket_id = this.socketRepo.getSocketIDFromMapForThisUser(to_user_id);
		let isOnline = undefined != to_user_socket_id;
		chat_user_details.to_user_online_status = isOnline;
		this.socketServices.sendBackToClient(socket, socketConsts.SUB_EVENT_IS_USER_CONNECTED, chat_user_details);
	}

	disconnectHandler(socket){
		console.log('Disconnected ' + socket.id);
		this.socketRepo.removeUserWithSocketIDFromMap(socket.id);
		socket.removeAllListeners(socketConsts.SUB_EVENT_RECEIVE_MESSAGE);
		socket.removeAllListeners(socketConsts.SUB_EVENT_IS_USER_CONNECTED);
		socket.removeAllListeners(socketConsts.ON_DISCONNECT);
	}
}

module.exports = SocketController;