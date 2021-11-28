#!/bin/awk -f

@include "utils.awk"

NR==1 { name=$0 }
NR==2 { type=$0 }
NR==3 { vaddr=$0 }
NR==4 { paddr=$0 }

END {
	webpage=""

	getline < "House"
	house=$0

	RS="\0"

	headerfile = house ".yard/head"
	getline < headerfile
	head=$0

	navfile = house ".yard/nav"
	getline < navfile
	nav=$0

	mapfile = house ".yard/minimap"
	getline < mapfile
	minimap=$0

	roomlocation=sprintf("<script>var roomlocation = { A: %s, B: %s, C: %s }</script>\n", getA(vaddr), getB(vaddr), getC(vaddr))


	webpage = webpage "<html>\n<head>\n"
	webpage = (webpage head) "\n</head>\n"
	webpage = webpage nav
	webpage = webpage roomlocation
	webpage = webpage minimap

	# print house "/" paddr
	# print "mkdir -p '" house "/" paddr
	system("mkdir -p '" house "/" paddr "'")

	switch(type) {
	case "info":
		printf "[CONSTRUCT info %s]\n", name
		contentfile=house ".truck/" name ".md"
		# print contentfile
		outfile=house "/" paddr "/index.html"
		# print "echo '" webpage "' >> '" outfile "'"
		system("echo '" webpage "' > '" outfile "'")
		system("cat '" contentfile "' | pandoc -f markdown >> " outfile);
		system("echo '</html>' >> '" outfile "'")
		break;
	default:
		printf "[FATAL: mysterious room]\n"
	}

}
