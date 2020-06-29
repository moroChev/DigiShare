const SocketController = require('./socketUtils/socket_controller');
const socketConsts = require('./socketUtils/socket_consts');
const SocketServices = require('./socketUtils/socket_services');

const MessageRepositoryMongo = require('./repositories/Messages/messageRepositoryMongoDb');
const RoomRepositoryMongo = require('./repositories/Rooms/roomRepositoryMongoDb');
const MessageService = require('./services/messageService');

const {socketRepo,notificationController} = require('./utility/modulesInjection');

//Dependencies injection ( no need for that )
//let socketRepo = new SocketRepo();
let socketServices = new SocketServices();
let messageRepo = new MessageRepositoryMongo();
let roomRepo = new RoomRepositoryMongo();
let messageSvc = new MessageService(messageRepo, roomRepo);
let socketController = new SocketController(messageSvc, socketServices, socketRepo);


exports.onEachUserConnection = (socket)=>{
	console.log('================================');
	console.log('Connected => Socket ID: ' + socket.id + ', User: ' + socketServices.stringifyToJson(socket.handshake.query));
	var from_user_id = socket.handshake.query.from;
	let userMapVal = { socket_id: socket.id };
	socketRepo.addUserToMap(from_user_id, userMapVal);
	socketRepo.printUserMap();
	socketRepo.printOnLineUsers();

	//Listeners
	onMessage(socket);

	onMessageSeen(socket);

	onCheckOnline(socket);

	onDisconnect(socket);

	notificationController.setSocket(socket);
}

function onCheckOnline(socket) {
	socket.on(socketConsts.EVENT_IS_USER_ONLINE, function(chat_user_details) {
		socketController.onlineCheckHandler(socket, chat_user_details);
	});
}

function onMessage(socket) {
	socket.on(socketConsts.EVENT_SINGLE_CHAT_MESSAGE, function (chat_message) {
		socketController.singleChatHandler(socket, chat_message);
	});
}

function onMessageSeen(socket) {
	socket.on(socketConsts.EVENT_MESSAGE_SEEN, function (chat_message) {
		socketController.messageSeenHandler(socket, chat_message);
	});
}

function onDisconnect(socket) {
	socket.on(socketConsts.ON_DISCONNECT, function() {
		socketController.disconnectHandler(socket);
	});
}