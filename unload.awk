#!/bin/awk -f

# Notes:
# break up into pieces?

@include "utils.awk"

function mkpipe(name, url) {
	pipes[name]=url;
	printf "[PLUMBING %s => %s]\n", name, url
}

function mkroom(name, type, vaddr, paddr) {
	# skip empty lines
	if (name == "") {
		return;
	}

	# it's like an array of structs but modular
	nameents[roomcnt] = name;
	typeents[roomcnt] = type;
	vaddrents[roomcnt] = vaddr;
	paddrents[roomcnt] = paddr
	roomcnt++;
}

function mkasset(filename, dest) {
	# printf "f: %s, d: %s\n", filename, dest
	assetcmds[assetcnt] = "echo '" dest "' > '" house ".yard/" filename ".asset'"
	assetcnt++
}

BEGIN {
	split("", navents);
	split("", typeents);
	split("", vaddrents);
	split("", paddrents);
	split("", assetcmds);
	roomcnt = 0;
	assetcnt = 0;
	navfile="";
	headerfile="";
	house = "";
}

/#/ { next; }

/=>/ { mkpipe($1,$3); next;}

/^House/ {
	for (i=2; i<=NF; ++i) {
		house = house $i;
	}
	next;
}

/@/ { mkasset($2, $3); next }

# validate better?
!/=>/ { mkroom($1,$2,$3,$4); next;}

function genhouse() {
	# add house name to nav
	navfile = navfile sprintf("<h1>%s</h1>\n", house);

	# export House name
	system("echo '" house "' > House")


	yard=house ".yard"
	system("ls '" yard "' &>/dev/null && rm -rf '" yard "'; mkdir '" yard "'")

	# generate the coordinate file
	coordcmd=sprintf("echo '%%s' >> %s.yard/coordinator", house);
	system("echo '# COORDINATOR 0.1' > " house ".yard/coordinator")
	printf "[HOUSE %s]\n", house
}

function genhead() {
	RS="\0"
	style=house ".truck/" "style.css"
	getline < style
	headerfile = headerfile "<style>\n" $0 "</style>\n"

	printf "[ASSEMBLE head]\n"
	system("echo '" headerfile "' > " house ".yard/head")
}

function gennav() {
	# for (i in nameents) {
	# 	name=nameents[i];
	# 	paddr=paddrents[i];


	# 	navfile = navfile sprintf( "<a href=\"%s/index.html\"> %s </a>", paddrtolink(paddr), name)

	# 	# arrange in the form: link | link | link
	# 	if (i < roomcnt - 1) {
	# 		navfile = navfile sprintf(" | ")
	# 	} else {
	# 		navfile = navfile  sprintf("\n");
	# 	}
	# }
	# navfile = navfile "haha there is no nav good luck"

	# nah lets forget about nav for now

	printf "[ASSEMBLE nav]\n"
	system("echo '" navfile "' > " house ".yard/nav")
}

function genassets() {
	for (i = 0; i < assetcnt; ++i) {
		system(assetcmds[i])
	}
}

function gencoords(idx) {
	coords=vaddrents[i]	

	# add an entry for this room to the coordinator file
	# relidx=index(paddrents[i], "/")
	# reladdr= ".." substr(paddrents[i], relidx)
	coordswithdest = coords " " paddrents[i]
	_coordcmd=sprintf(coordcmd, coordswithdest);
	system(_coordcmd)
}

END {
	if (house == "") {
		printf "[FATAL: no house]\n"
		exit 1
	}
	genhouse();
	genhead();
	gennav();
	genassets();

	for (i=0; i<roomcnt; ++i) {
		gencoords(i);
		roomfile=nameents[i] "\n" typeents[i] "\n" vaddrents[i] "\n" paddrents[i]
		system("echo '" roomfile "' > " house ".yard/" nameents[i] ".room")
		printf "[SKETCH %s]\n", nameents[i]
	}
}
