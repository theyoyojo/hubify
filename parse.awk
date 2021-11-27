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
	navents[naventcnt] = name;
	
	split(paddr, patharr, "/");

	printf "PATHARR[0]=%s\n", patharr[1];
	destents[naventcnt] = patharr[1];
	naventcnt++
}

BEGIN {
	split("", navents)
	split("", destents)
	entcnt = 0
}

# /^.*#.*/  {}
!/#/ && /=>/ { mkpipe($1,$3) }

# validate better?
!/#/ && !/=>/ { mkroom($1,$2,$3,$4) }

!/#/ && /House/ {
	house = "";
	for (i=2; i<=NF; ++i) {
		house = house $i;
	}
}

function printnav() {
	for (i in navents) {
		ent=navents[i];
		destname=destents[i];
		realdest=pipes[destname];
		# printf "link %s => %s\n", ent, realdest
		printf "<a href=\"%s\"> %s </a>", realdest, destname
		if (i < encnt - 1) {
			printf " | ";
		} else {
			printf "\n";
		}
	}
}

function printhouse() {
	printf "<h1>%s</h1>\n", house;
}

END {
	printhouse();
	printnav();
}
