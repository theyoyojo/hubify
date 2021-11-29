#!/bin/awk -f

BEGIN {
	FS="." 
	getline < "House"
	house=$0
}

{
	assetfile= house ".yard/" $0

	filename=""
	for (i = 1; i < NF; ++i) {
		filename = filename $i
		if (i < NF - 1) {
			filename = filename "."
		}
	}
}

END {
	getline < assetfile
	paddr=$0

	assetpath= house ".truck/" filename

	printf "[DECORATE %s with %s]\n", paddr, filename
	system("cp '" assetpath "' '" house "/" paddr "'")
}
