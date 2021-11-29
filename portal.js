// assumes roomlocation and minimap.js are above
function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

async function portal(coords) {
	var p = document.getElementById("portal")
	p.innerHTML = "PORTAL to " + roomname + " (" + coords.A + "," + coords.B + "," + coords.C + ")"
	p.innerHTML += "\nTeleporting in 5 seconds"
	for (var i = 0; i < 5; ++i) {
		p.innerHTML += "."
		await sleep(1000)
	}
	attemptmove(coords)
}
