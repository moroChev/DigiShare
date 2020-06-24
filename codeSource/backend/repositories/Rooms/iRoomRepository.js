class IRoomRepository{

    // create a new room
    async createRoom(msg){};

    // find & return a room
    async findRoomByChatId(chat_id){};

    // find & update a room
    async findAndUpdateRoom(msg){};

    // fetch rooms for FromUser
    async findRoomsForFromUser(from){}

    // fetch rooms for To User
    async findRoomsForToUser(to){}
}

module.exports = IRoomRepository;