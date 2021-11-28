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

	roomlocation=sprintf("<script>var roomlocation = { A: %s, B: %s, C: %s };roomname=\"%s\"</script>\n", getA(vaddr), getB(vaddr), getC(vaddr), name)


	webpage = webpage "<html>\n<head>\n"
	webpage = (webpage head) "\n</head>\n<body>\n"
	webpage = webpage nav
	webpage = webpage roomlocation
	webpage = webpage minimap

	system("mkdir -p '" house "/" paddr "'")

	outfile=house "/" paddr "/index.html"
	system("echo '" webpage "' > '" outfile "'")

	printf "[CONSTRUCT %s %s]\n", type, name
	switch(type) {
	case "info":
		contentfile=house ".truck/" name ".md"
		system("cat '" contentfile "' | pandoc -f markdown >> " outfile);
		break;
	case "portal":
		wherefile=house ".truck/" name ".portal"
		# room + plan files?
		RS="\n"
		getline < wherefile
		coords=$0

		RS="\0"
		getline < "portal.js"
		portaljs=$0

		cmd=sprintf("echo '<div id=\"portal\"></div><script>%s portal({A: %s, B: %s, C: %s})</script>' >> '%s'", portaljs, getA(coords), getB(coords), getC(coords), outfile)
		system(cmd)
		break
	default:
		printf "[FATAL: mysterious room]\n"
	}

	system("echo '</body>\n</html>' >> '" outfile "'")
}
