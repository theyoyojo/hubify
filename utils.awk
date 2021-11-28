function getA(coords) {
	split(coords, arr, ",")
	if (substr(arr[1], 0, 1) == "(") {
		A=substr(arr[1],2)
	} else {
		A=arr[1]
	}
	return A
}

function getB(coords) {
	split(coords, arr, ",")
	B=arr[2]
	return B
}

function getC(coords) {
	split(coords, arr, ",")
	if (substr(arr[3], length(arr[3]), 1) == ")") {
		C=substr(arr[3],0,length(arr[3])-1)
	} else {
		C=arr[3]
	}
	return C
}

function paddrtolink(paddr) {
	link=""
	split(paddr,patharr,"/")
	# for (i in patharr) {
	# 	printf "%d: %s\n", i, patharr[i]
	# }
	for (i = 0; i < length(patharr); ++i) {
		link = link "../"
	}
	link = link paddr
	return link
}
