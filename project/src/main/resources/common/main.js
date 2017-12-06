let io = require('socket.io').listen(50000);

let clientList = [];
let roomList = [];

function counter() {
	let i = 0;
	return function() {
		i += 1;
		return i;
	}
}

function Client(socket, data) {
	this.socketId = socket.id;
	this.userId = data.userId;
	this.sessionId = data.sessionId;
	for(let i in roomList) {
		if(roomList[i].roomNum == data.roomNum) {
			this.room = roomList[i];
		}
	}
}

function Room(data) {
	this.roomName = data.roomName;
	this.groupNum = data.groupNum;
	this.userCnt = 0;
	this.roomNum = this.counter();
}
Room.prototype.counter = counter();


io.sockets.on('connection', function(socket) {
	socket.on('join', function(data) {
		let client = new Client(socket, data);
		for(let i in clientList) {
			if(client.sessionId == clientList[i].sessionId) {
				clientList[i].disconnected = false;
				clientList[i].socketId = socket.id;
				return;
			}
		}

		for(let i in clientList) {
			if(clientList[i].userId==client.userId) {
			}
		}
		clientList.push(client);
		client.room.userCnt += 1;
	});

	socket.on('leave', function(data) {
		console.log('leave', data.userId);
		for(let i in clientList) {
			console.log(clientList[i].sessionId, data.sessionId);
			if(clientList[i].sessionId == data.sessionId) {
				console.log('in', i);
				let room = clientList[i].room;
				room.userCnt += -1;
				checkDelRoom(room);
				clientList.splice(i, 1);
				break;
			}
		}
	});

	socket.on('disconnect', function(data) {
		for(let i in clientList) {
			if(clientList[i].socketId == socket.id) {
				let client = clientList[i];
				let room = client.room;
				client.disconnected = true;
				setTimeout(function() {
					if(client.disconnected) {
						room.userCnt += -1;
						checkDelRoom(room);
						clientList.splice(i, 1);
					}
				}, 1000);
				break;
			}
		}
	});

	socket.on('send', function(data) {
		for(let i in clientList) {
			if(clientList[i].room.roomNum == data.roomNum) {
				io.to(clientList[i].socketId)
					.emit('sendAll', data);
			}
		}
	});

	socket.on('getRoomList', function (data) {
		let groupNum = data.groupNum;
		let res = [];
		for(let i in roomList) {
			if(roomList[i].groupNum == groupNum) {
				res.push(roomList[i]);
			}
		}
		socket.emit('getRoomList', { roomList: res });
	});

	socket.on('newRoom', function(data) {
		let room = new Room(data);
		roomList.push(room);
		socket.emit('newRoom', {roomNum: room.roomNum});
	});
});

function checkDelRoom(room) {
	let res = false;
	if(room.userCnt <= 0) {
		for(let j in roomList) {
			if(roomList[j].roomNum==room.roomNum) {
				roomList.splice(j, 1);
				res = true;
				break;
			}
		}
	}
	return res;
}