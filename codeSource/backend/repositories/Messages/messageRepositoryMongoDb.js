const Message = require('../../models/Message');
const IMessageRepository = require('./IMessageRepository');
      

class MessageRepositoryMongoDb extends IMessageRepository{

    constructor(){
        console.log('creating InStAnCe of MessageRepositoryMongoDb');
        super();
    };

    async createMessage(chat_message){
		console.log('in createMessage');
		//Create the message object
		let message;
		try{
			let msg = new Message(
				{
					chat_id: chat_message.chat_id,
					from: chat_message.from,
					to: chat_message.to,
					message: chat_message.message,
					sent_at: chat_message.sent_at,
					chat_type: chat_message.chat_type,
					to_user_online_status: chat_message.to_user_online_status,
					status: chat_message.status,
				}
			);
			message = await msg.save();
			console.log(`Successfully created message document.`);
		}catch(err){
			console.error(`Failed to create message document: ${err}`);
		}
		return message;
	}

	// update a message
	async updateMessage(chat_message){
		console.log('in updateMessage');
		let result;
        try{
            result = await Message.findOneAndUpdate({sent_at: chat_message.sent_at}, {$set: chat_message}, {new: true});
            return result;
        }catch(err){
            throw(err);
        }
	}
}


module.exports = MessageRepositoryMongoDb;