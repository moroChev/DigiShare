class MessageService{

	constructor(messageRepo, roomRepo){
        console.log('creating InStAnCe of MessageService');
        this.messageRepo = messageRepo;
        this.roomRepo = roomRepo;
    }

    // add the given message to its specified room if it exists or create one for it
    async addMessageToRoom(chat_message){
		console.log('in addMessageToRoom');
		//Create the message object
		let message = await this.messageRepo.createMessage(chat_message);
		if(message){
			try{
				// update the room if it exists
				let room = await this.roomRepo.findAndUpdateRoom(message);
				if(room)
					console.log(`Successfully updated room document.`);
				else{
					// create a new room for the given message
					console.log("No room document matches the provided query.");
					room = await this.roomRepo.createRoom(message);
					if(!room)
						return undefined;
				}
			}catch(err){
				console.error(`Failed to find and update room document: ${err}`);
				return undefined;
			}
		}
		return message;
	}

	// update the given chat_message
	async updateMessage(chat_message){
		console.log('in updateMessage');
		let message = await this.messageRepo.updateMessage(chat_message);
		if(message){
			console.log(`Successfully updated message document.`);
		}
		return message;
	}

	// fetch a room by chat_id with all its messages
	// we will modify this function to fetch only the latest 20 messages
	async getRoomByChatId(room_id){
		try{
			let room;
			room = await this.roomRepo.findRoomByChatId(room_id);
	        return room;
		}catch(err){
			throw(err);
		}
	}

	// fetch all rooms for a given user
	async getAllRoomsForUser(userId){
		try{
			let rooms;
			let rooms_from = await this.roomRepo.findRoomsForFromUser(userId);
			let rooms_to = await this.roomRepo.findRoomsForToUser(userId);
			if(rooms_from != null){
				if(rooms_to != null){
					rooms = rooms_from.concat(rooms_to);
				}else{
					rooms = rooms_from;
				}
			}else{
				rooms = rooms_to;
			}
			return rooms.sort((a, b) => b.last_message.sent_at - a.last_message.sent_at);
		}catch(err){
			throw(err);
		}
	}
}

module.exports = MessageService;