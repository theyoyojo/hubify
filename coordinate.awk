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
	mapfile = mapfile sprintf("<table style=\"position:absolute;overflow:hidden;visibility:hidden;\" id=\"coordtab\">\n\t<tr>\n\t\t<th>A</th>\n\t\t<th>B</th>\n\t\t<th>C</th>\n\t\t<th>location</th>\n\t</tr>\n")
	for (i=0; i < n; ++i) {
		# printf "(%s,%s,%s)\n", As[i], Bs[i], Cs[i]
		mapfile = mapfile sprintf("<tr>\n\t\t<td>%s</td>\n\t\t<td>%s</td>\n\t\t<td>%s</td>\n\t\t<td>%s</td>\n\t</tr>\n", As[i], Bs[i], Cs[i], locations[i])
		maparr = maparr "[ " As[i] ", " Bs[i] ", " Cs[i] ", \"" locations[i] "\" ], "

	}

	mapfile = mapfile "</table>\n"
	maparr = maparr "]\n"

	# <div style="position:relative;min-width:960px">
 # <img src="..." style="position: absolute;right:0;top:0" />
# </div>

	mapfile = mapfile "<canvas id=\"minimap\" width=\"400\" height=\"200\" style=\"border:1px solid #000000;position:absolute;right:0;top:0\"></canvas>"

	RS="\0"
	getline < "minimap.js"
	mapfile = mapfile "<script>" maparr $0 "</script>\n"

	system("echo '" mapfile "' > " house ".yard/minimap")
}
