#!/bin/awk -f

@include "utils.awk"

BEGIN {
	# coordinate file is named after the House
	getline < "House"
	printf "[COORDINATE %s]\n", $0
	house=$0
	n=0
	mapfile=""
	maparr="var maparr = [ "
}

/#/ { next }

{
	As[n]=getA($1)
	Bs[n]=getB($1)
	Cs[n]=getC($1)
	locations[n] = $2
	n++
}

END {
	for (i=0; i < n; ++i) {
		# printf "(%s,%s,%s)\n", As[i], Bs[i], Cs[i]
		maparr = maparr "[ " As[i] ", " Bs[i] ", " Cs[i] ", \"" locations[i] "\" ], "

	}

	maparr = maparr "]\n"

	# <div style="position:relative;min-width:960px">
 # <img src="..." style="position: absolute;right:0;top:0" />
# </div>

	mapfile = mapfile "<canvas id=\"minimap\" width=\"400\" height=\"200\" style=\"border:1px solid #000000;position:fixed;right:0;top:0\"></canvas><div id=\"mapinfo\" style=\"border:1px solid #000000;position:fixed;right:0;top:200;width:400;height:20;text-align:center;padding-top:3px\"></div>"

	RS="\0"
	getline < "minimap.js"
	mapfile = mapfile "<script>" maparr $0 "</script>\n"

	system("echo '" mapfile "' > " house ".yard/minimap")
}
