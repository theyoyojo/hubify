#!/bin/awk -f

#/=>/ { print }

function mkpipe(name, url) {
	printf "PIPE: name=%s url=%s\n", name, url;
	pipes[name]=url
}

function mkroom(name, type, vaddr, paddr) {
	printf("ROOM: name=%s, type=%s, vaddr=%s paddr=%s\n", name, type, vaddr, paddr)

	if (name == "") {
		printf "empty line: skip\n";
		return
	}
	navents[roomcnt] = name;

	pathidx = index(paddr, "/")
	
	split(paddr, patharr, "/");

	printf "PATHARR[0]=%s\n", patharr[1];
	destents[roomcnt] = patharr[1];
	pathents[roomcnt] = substr(paddr, pathidx)
	roomcnt++
}

BEGIN {
	split("", navents)
	split("", destents)
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
}

END {
	genhouse();
	gennav();

	for (i=0; i<roomcnt; ++i) {
		destname=destents[i];
		realtest=pipes[destname];
		protidx=index(realdest, "://");
		outdir=substr(realdest, protidx+3)
		outdir = outdir pathents[i]
		# printf "outfile=%s\n", outdir

		ensuredir=sprintf("mkdir -p %s\n", outdir)
		printf "ensuredir=%s\n", ensuredir
		system(ensuredir)
	
		outfile = outdir "/index.html"
		cmd=sprintf("echo '%s' > %s", headerfile, outfile)
		# printf "cmd=%s\n", cmd
		system(cmd)
	}
}
