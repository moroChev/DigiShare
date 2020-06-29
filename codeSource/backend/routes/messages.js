const express = require('express'),
      auth = require('../middleware/auth');

const MessageRepositoryMongo = require('../repositories/Messages/messageRepositoryMongoDb'),
	  RoomRepositoryMongo = require('../repositories/Rooms/roomRepositoryMongoDb'),
      MessageService = require('../services/messageService'),
      MessageController = require('../controllers/messages') ;


let router = express.Router();

//Dependencies injection ( no need for that )
let messageRepo = new MessageRepositoryMongo();
let roomRepo = new RoomRepositoryMongo();
let messageSvc = new MessageService(messageRepo, roomRepo);
let messageController = new MessageController(messageSvc);


router.get("/room/:id", auth, (req,res,next) => messageController.getRoomByChatId(req,res,next));
router.get("/:id", auth, (req,res,next) => messageController.getAllRoomsForUser(req,res,next));


module.exports = router;