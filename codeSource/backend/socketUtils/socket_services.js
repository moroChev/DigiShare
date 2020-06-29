class SocketServices{
	constructor(){
		console.log('creating InStAnCe of SocketService');
	}

	stringifyToJson(data) {
		return JSON.stringify(data);
	}

	sendBackToClient(socket, event, chat_message){
		socket.emit(event, this.stringifyToJson(chat_message));
	}

	sendToConnectedSocket(socket, to_user_socket_id, event, chat_message) {
		socket.to(`${to_user_socket_id}`).emit(event, this.stringifyToJson(chat_message));
	}
}

module.exports = SocketServices;