#!/bin/awk -f

# Notes:
# break up into pieces?

@include "utils.awk"

function mkpipe(name, url) {
	# printf "PIPE: name=%s url=%s\n", name, url;
	pipes[name]=url
}

function mkroom(name, type, vaddr, paddr) {
	# printf("ROOM: name=%s, type=%s, vaddr=%s paddr=%s\n", name, type, vaddr, paddr)

	if (name == "") {
		# printf "empty line: skip\n";
		return
	}
	navents[roomcnt] = name;
	typeents[roomcnt] = type;
	coordents[roomcnt] = vaddr;

	pathidx = index(paddr, "/")
	
	split(paddr, patharr, "/");

	# printf "PATHARR[0]=%s\n", patharr[1];
	destents[roomcnt] = patharr[1];
	pathents[roomcnt] = substr(paddr, pathidx)
	roomcnt++
}

BEGIN {
	split("", navents)
	split("", destents)
	split("", pathents)
	split("", typeents)
	split("", coordents)
	roomcnt = 0
	headerfile=""
}

/#/ { next }

# /^.*#.*/  {}
/=>/ { mkpipe($1,$3); next;}

/House/ {
	house = "";
	for (i=2; i<=NF; ++i) {
		house = house $i;
	}
	next;
}

# validate better?
!/=>/ { mkroom($1,$2,$3,$4) }

function gennav() {
	for (i in navents) {
		ent=navents[i];
		destname=destents[i];
		realdest=pipes[destname];
		path=pathents[i]
		# printf "link %s => %s\n", ent, realdest
		headerfile = headerfile sprintf( "<a href=\"%s/index.html\"> %s </a>", realdest path, navents[i])
		if (i < roomcnt - 1) {
			headerfile = headerfile sprintf(" | ")
		} else {
			headerfile = headerfile  sprintf("\n");
		}
	}
}

function genhouse() {
	headerfile = headerfile sprintf("<h1>%s</h1>\n", house);
	coordcmd=sprintf("echo '%%s' >> %s.coords", house);
	thiscoordcmd=sprintf("echo '# COORDINATOR 0.1' > %s.coords", house);
	system(thiscoordcmd)
	printf "[HOUSE %s]\n", house

	housecmd=sprintf("echo '%s' > House", house)
	system(housecmd)
}

function gencoords(idx) {
	coords=coordents[i]	
	# printf "COORDS: %s\n", coords;
	thiscoordcmd=sprintf(coordcmd, coords);
	# printf "cmd: %s\n", thiscoordcmd;
	system(thiscoordcmd)

	roomlocation=sprintf("<script>var roomlocation = { A: %s, B: %s, C: %s }</script>\n", getA(coords), getB(coords), getC(coords))
	# printf "loc: %s\n", roomlocation
	headerfile = headerfile roomlocation
}

END {
	genhouse();
	gennav();

	for (i=0; i<roomcnt; ++i) {
		
		gencoords(i);

		destname=destents[i];
		realtest=pipes[destname];
		protidx=index(realdest, "://");
		outdir=substr(realdest, protidx+3)
		outdir = outdir pathents[i]
		# printf "outfile=%s\n", outdir

		ensuredir=sprintf("mkdir -p %s\n", outdir)
		# printf "ensuredir=%s\n", ensuredir
		system(ensuredir)
	
		outfile = outdir "/index.html"
		headercmd=sprintf("echo '%s' > %s", headerfile, outfile)
		# printf "cmd=%s\n", cmd
		system(headercmd)
		
		type=typeents[i]
		switch (type) {
		case "info":
			printf "[CONSTRUCT info %s]\n", navents[i]
			contentcmd=sprintf("cat %s.md | pandoc -f markdown >> %s", navents[i], outfile);
			# printf "%s\n", contentcmd
			system(contentcmd);
			break;
		default:
			printf "WHAT IS GOING ON AHHHH"
		}
	}
}
