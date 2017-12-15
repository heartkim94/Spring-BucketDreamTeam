let io = require('socket.io').listen(50000);

// let clientList = [];
let roomList = [];


io.sockets.on('connection', function(socket) {
	socket.on('join', function(data) {
		let client = new Client(socket, data);
		let room=null;
		for(let i in roomList) {
			if(client.roomNum == roomList[i].roomNum) {
				room = roomList[i];
				break;
			}
		}
		let clientList = room.clientList;
		let paintList = [];
		for(let i in clientList) {
			let paint = {
				paintNum: clientList[i].paintNum,
				paint: clientList[i].paint,
				userId: clientList[i].userId
			}
			paintList.push(paint);
		}

		for(let i in clientList) {
			if(client.sessionId == clientList[i].sessionId) {
				clientList[i].disconnected = false;
				clientList[i].socketId = socket.id;
				socket.emit("join", {
					log: room.log,
					paintNum: clientList[i].paintNum,
					paint: clientList[i].paint,
					paintList: paintList
				});
				return;
			}
		}

		client.paintNum = room.paintCounter();
		clientList.push(client);

		
		socket.emit("join", {	// 채팅 로그 전송
			log: room.log,
			paintNum: client.paintNum,
			paintList: paintList
		});
	});

	socket.on('leave', function(data) {
		let room, clientList;
		for(let i=0; i<roomList.length; i++) {
			room = roomList[i];
			clientList = room.clientList;
			for(let j=0; j<clientList.length; j++) {
				if(clientList[j].sessionId == data.sessionId) {
					clientList.splice(j, 1);
					room.checkDel(i);
					return;
				}
			}
		}
	});

	socket.on('disconnect', function(data) {
		let room
		for(let i in roomList) {
			room = roomList[i];
			let clientList = room.clientList;
			for(let j in clientList) {
				if(clientList[j].socketId == socket.id) {
					let client = clientList[j];
					client.disconnected = true;
					setTimeout(function() {
						if(client.disconnected) {
							clientList.splice(j, 1);
							room.checkDel(i);
						}
					}, 1000);
					break;
				}
			}
		}
	});

	socket.on('send', function(data) {
		let logged = false;
		let room;
		for(let i in roomList) {
			if(roomList[i].roomNum == data.roomNum) {
				room = roomList[i];
			}
		}
		if(!logged) {	// 메세지 로깅
			switch(data.type) {
			case 'msg':
				room.log.push({userId: data.userId, msg: data.msg});
				break;
			case 'paint':
				for(let i in room.clientList) {
					let client = room.clientList[i];
					if(client.paintNum == data.paintNum) {
						client.paint = data.paint;
						break;
					}
				}
				break;
			}
			logged = true;
		}
		data.sessionId = undefined;
		for(let i in room.clientList) {
			let client = room.clientList[i];
			io.to(client.socketId).emit('sendAll', data);
		}
	});

	socket.on('getRoomList', function(data) {
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

	socket.on('switchPaint', function(data) {
		console.log(data);
		let room;
		for(let i in roomList) {
			if(data.roomNum == roomList[i].roomNum) {
				room = roomList[i];
				break;
			}
		}
		for(let i in room.clientList) {
			console.log(room.clientList[i].paintNum);
			if(data.paintNum == room.clientList[i].paintNum) {
				socket.emit('switchPaint', {
					paintNum: data.paintNum,
					paint: room.clientList[i].paint
				});
				break;
			}
		}
	});
});


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
	this.paint = data.paint;
	/*
	for(let i in roomList) {
		if(roomList[i].roomNum == data.roomNum) {
			this.room = roomList[i];
		}
	}
	*/
	this.roomNum = data.roomNum;
}

function Room(data) {
	this.roomName = data.roomName;
	this.groupNum = data.groupNum;
	this.clientList = [];
	this.roomNum = this.counter();
	this.log = [];
	this.paintCounter = counter();
}
Room.prototype.counter = counter();
Room.prototype.checkDel = function(index) {
	let res = false;
	if(this.clientList.length == 0
	&& roomList[index].roomNum==this.roomNum) {
		roomList.splice(index, 1);
		res = true;
	}
	return res;
}