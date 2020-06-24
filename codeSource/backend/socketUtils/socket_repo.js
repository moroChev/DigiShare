class SocketRepo{

	constructor(){
		console.log('creating InStAnCe of SocketRepo');
		this.userMap = new Map();
	}

	addUserToMap(key_user_id, socket_id) {
		this.userMap.set(key_user_id, socket_id);
	}

	printOnLineUsers(){
		console.log('Online Users: ' + this.userMap.size);
	}

	printUserMap(){
		console.log(this.userMap);
	}

	getSocketIDFromMapForThisUser(to_user_id){
		let userMapVal = this.userMap.get(`${to_user_id}`);
		if(undefined == userMapVal)
			return undefined;
		return userMapVal.socket_id;
	}

	removeUserWithSocketIDFromMap(socket_id){
		console.log('Deleting User: ' + socket_id);
		let toDeleteUser;
		for (let key of this.userMap) {
			let userMapValue = key[1];
			if(userMapValue.socket_id == socket_id) {
				toDeleteUser = key[0];
			}
		}
		console.log('Deleting User: ' + toDeleteUser);
		if(undefined != toDeleteUser){
			this.userMap.delete(toDeleteUser);
		}
		console.log(this.userMap);
		this.printOnLineUsers();
	}
}

module.exports = SocketRepo;