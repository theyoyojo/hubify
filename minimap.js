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
	var x,y,z
	// coordinate table
	ctab = document.getElementById("coordtab")

	console.log(ctab)

	for (var i = 1, row; row = ctab.rows[i]; ++i) {
		var tmp
		for (var j = 0, col; col = row.cells[j]; ++j) {
			if (j === 0) {
				x = col.innerText
				if (!(x in coordmap)) {
					coordmap[x] = {}
				}
				tmp = coordmap[x]
			} else if (j === 1) {
				y = col.innerText
				if (!(y in tmp)) {
					tmp[y] = {}
				}
				tmp = tmp[y]
			} else if (j === 2) {
				z = col.innerText
				if (!(z in tmp)) {
					tmp[z] = {}
				}
				// add page link to map
				tmp[z] = row.cells[3].innerText
			}
			// what to do with z? color?
		}
		console.log(x.y)
		mkroom(x,y)
	}

}

// a key map of the controls
var ctrls = {
  37: 'left',
  38: 'up',
  39: 'right',
  40: 'down',
}

document.addEventListener('keydown', function(e) {

	var key = e.keyCode
	
	console.log(e.keyCode)

	if (ctrls[e.keyCode] === 'left') {
		alert("asdfasdf")
	}

});

var canvas = document.getElementById("minimap");
var ctx = canvas.getContext("2d");

x = CC(0,0)
y = CC(10,10)
console.log(roomlocation)
drawmap()
