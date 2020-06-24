class MessageController{

	constructor(messageSvc){
        console.log('creating InStAnCe of MessageController');
        this._messageService = messageSvc;
    }

	async getRoomByChatId(req, res, next){
		console.log("get Room");
		var room_id = req.params.id;
		var result;
		try{
			result = await this._messageService.getRoomByChatId(room_id);
	        if(result == undefined){
                res.status(404).json({result : undefined});
            }else{
                res.status(200).json(result);
            }
        }catch(err){
            res.status(500).json({error : err});
        }
	}

    async getAllRoomsForUser(req, res, next){
        console.log("get Rooms for FromUser");
        var user_id = req.params.id;
        var result;
        try{
            result = await this._messageService.getAllRoomsForUser(user_id);
            if(result == undefined){
                res.status(404).json({result : undefined});
            }else{
                res.status(200).json(result);
            }
        }catch(err){
            res.status(500).json({error : err});
        }
    }
}

module.exports = MessageController;