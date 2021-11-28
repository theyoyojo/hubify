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
	// console.log(x)
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

	console.log("THE CTAB", ctab)

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

	// for (var i = 1, row; row = ctab.rows[i]; ++i) {
	// 	var tmp
	// 	for (var j = 0, col; col = row.cells[j]; ++j) {
			// console.log("i", i, "j", j, "text", col.innerText, "x")
			// switch(j) {
			// case 0:
			// 	x = col.innerText
			// 	if (!(x in coordmap)) {
			// 		coordmap[x] = {}
			// 	}
			// 	tmp = coordmap[x]
			// 	break
			// case 1:
			// 	y = col.innerText
			// 	if (!(y in tmp)) {
			// 		tmp[y] = {}
			// 	}
			// 	tmp = tmp[y]
			// 	break
			// case 2:
			// 	z = col.innerText
			// 	if (!(z in tmp)) {
			// 		tmp[z] = {}
			// 	}
			// 	// add page link to map
			// 	tmp[z] = row.cells[3].innerText
			// 	break
			// }
			// what to do with z? color?
		// }
		// console.log(x.y)
		// mkroom(x,y)
	// }
}

// a key map of the controls
var ctrls = {
  37: "left",
  38: "up",
  39: "right",
  40: "down",
}

document.addEventListener("keydown", function(e) {

	var key = e.keyCode

	var nxt = JSON.parse(JSON.stringify(roomlocation))
	
	console.log("THE NEXT:", nxt)

	switch(ctrls[e.keyCode]) {
	case "right":
		console.log("HELLO")
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
	}

	console.log("NXT A", nxt.A)

	if (nxt.A in coordmap) {
		console.log("AAA", coordmap[nxt.A])
		if (nxt.B in coordmap[nxt.A]) {
			console.log("BBB", coordmap[nxt.B])
			if (nxt.C in coordmap[nxt.A][nxt.B]) {
				console.log("CCC", coordmap[nxt.C])
				console.log(nxt)
				window.location.href = coordmap[nxt.A][nxt.B][nxt.C]
			}
		}
	}

});

var canvas = document.getElementById("minimap");
var ctx = canvas.getContext("2d");
console.log(roomlocation)
drawmap()
