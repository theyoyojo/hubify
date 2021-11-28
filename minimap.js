// width, height
var WW = 400
var HH = 200

// room size
var RR = 20

// center
var WWo = WW/2
var HHo = HH/2


// convert coordinates: cartesian to canvas
function CC(a,b) {
	a += WWo
	b = HHo - b

	return {a,b}
}

// canvas coords of current room
var roomcoords = CC(roomlocation.A * RR, roomlocation.B * RR)

function mksquare(a,b,size) {
	girth = size/2
	x = CC(a,b)
	ctx.strokeRect(x.a - girth, x.b - girth, size, size)

	if (x.a === roomcoords.a && x.b === roomcoords.b) {
		ctx.fillStyle = "red";
		ctx.fillRect(x.a - girth, x.b - girth, size, size)
	}

}


function mkroom(a,b) {
	a *= RR
	b *= RR
	mksquare(a,b,RR)
}

var coordmap = {}

function drawmap() {
	var x,y,z,tmp
	// coordinate table
	ctab = document.getElementById("coordtab")

	for (var i = 0; i < maparr.length; ++i) {
		if (!((x = maparr[i][0]) in coordmap)) {
			coordmap[x] = {}
		}
		tmp = coordmap[x]
		if (!((y = maparr[i][1]) in tmp)) {
			tmp[y] = {}
		}
		tmp = tmp[y]
		if (!((z = maparr[i][2]) in tmp)) {
			tmp[z] = {}
		}
		tmp[z] = maparr[i][3]

		mkroom(x,y)
	}

}

// a key map of the controls
var ctrls = {
  37: "left",
  38: "up",
  39: "right",
  40: "down",
}

function attemptmove(coords) {
	if (coords.A in coordmap) {
		if (coords.B in coordmap[coords.A]) {
			if (coords.C in coordmap[coords.A][coords.B]) {
				window.location.href = coordmap[coords.A][coords.B][coords.C]
			}
		}
	}
}

document.addEventListener("keydown", function(e) {

	var key = e.keyCode

	var nxt = JSON.parse(JSON.stringify(roomlocation))
	
	switch(ctrls[e.keyCode]) {
	case "right":
		nxt.A += 1
		break
	case "left":
		nxt.A -= 1
		break
	case "up":
		nxt.B += 1
		break
	case "down":
		nxt.B -= 1
		break
	default:
		return
	}

	attemptmove(nxt)

});

var canvas = document.getElementById("minimap");
var ctx = canvas.getContext("2d");
drawmap()
