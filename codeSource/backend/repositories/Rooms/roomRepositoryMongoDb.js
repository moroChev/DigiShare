const Message = require('../../models/Message');
const Room = require('../../models/Room');
const IRoomRepository = require('./IRoomRepository');
      

class RoomRepositoryMongoDb extends IRoomRepository{

    constructor(){
        console.log('creating InStAnCe of RoomRepositoryMongoDb');
        super();
    };

    async createRoom(msg){
		console.log("in createRoom");
		//Create the message object
		let room;
		try{
			let rm = new Room(
				{
					chat_id: msg.chat_id,
					from: msg.from,
					to: msg.to,
					last_message: msg._id,
					messages: [msg._id],
				}
			);
			room = await rm.save();
			console.log(`Successfully created room document.`);
		}catch(err){
			console.error(`Failed to create room document: ${err}`);
		}
		return room;
	}

	async findRoomByChatId(chat_id){
		let room;
		try{
			room = await Room.findOne({chat_id: chat_id})
				.populate(
		            {
		                path: 'messages',
		                model: 'Message'
		            }
		        )
		        .populate(
		            {
		                path: 'last_message',
		                model: 'Message'
		            }
		        )
		        .populate(
		            {
		                path: 'from',
		                model: 'Employee'
		            }
		        )
		        .populate(
		            {
		                path: 'to',
		                model: 'Employee'
		            }
		        );
		}catch(err){
			console.error(`Failed to find room document: ${err}`);
		}
		return room;
	}

	async findAndUpdateRoom(msg){
		let room = await Room.findOneAndUpdate(
			{chat_id: msg.chat_id},
			{ 
				$push: { "messages": msg },
				$set: {"last_message": msg._id}
			},
			{ safe: true, new: true}
		);
		return room;
	}

	async findRoomsForFromUser(from){
		let rooms;
		try{
			rooms = await Room.find({from: from})
				.populate(
		            {
		                path: 'messages',
		                model: 'Message'
		            }
		        )
				.populate(
		            {
		                path: 'last_message',
		                model: 'Message'
		            }
		        )
		        .populate(
		            {
		                path: 'from',
		                model: 'Employee'
		            }
		        )
		        .populate(
		            {
		                path: 'to',
		                model: 'Employee'
		            }
		        );
		}catch(err){
			console.error(`Failed to find rooms for FromUser: ${err}`);
		}
		return rooms;
	}

	async findRoomsForToUser(to){
		let rooms;
		try{
			rooms = await Room.find({to: to})
				.populate(
		            {
		                path: 'messages',
		                model: 'Message'
		            }
		        )
				.populate(
		            {
		                path: 'last_message',
		                model: 'Message'
		            }
		        )
		        .populate(
		            {
		                path: 'from',
		                model: 'Employee'
		            }
		        )
		        .populate(
		            {
		                path: 'to',
		                model: 'Employee'
		            }
		        );
		}catch(err){
			console.error(`Failed to find rooms for ToUser: ${err}`);
		}
		return rooms;
	}
}


module.exports = RoomRepositoryMongoDb;