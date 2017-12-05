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
	clientList.push(this);
}

function Room(data) {
	this.roomName = data.roomName;
	this.groupNum = data.groupNum;
	this.userCnt = 0;
	this.roomNum = this.counter();
	roomList.push(this);
}
Room.prototype.counter = counter();


io.sockets.on('connection', function(socket) {
	socket.on('join', function(data) {
		console.log(data);
		let client = new Client(socket, data);
		if(client.room == undefined) {
			let room = new Room(data);
			socket.emit('join', {
				result: 'fail',
				roomNum: room.roomNum
			});
			return;
		}

		for(let i in clientList) {
			if(clientList[i].userId==client.userId) {
			}
		}
		client.room.userCnt += 1;
	});

	socket.on('disconnect', function(data) {
		for(let i in clientList) {
			if(clientList[i].socketId == socket.id) {
				let client = clientList[i];
				let room = client.room;
				if(room) {
				room.userCnt -= 1;
					if(room.userCnt <= 0) {
						for(let j in roomList) {
							if(roomList[j].roomNum==room.roomNum) {
								roomList.splice(j, 1);
							}
						}
					}
				}
				clientList.splice(i, 1);
				console.log(clientList.length);
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
		socket.emit('newRoom', {roomNum: room.roomNum});
	});
});