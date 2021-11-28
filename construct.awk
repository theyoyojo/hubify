#!/bin/awk -f

	# return sprintf("<script>var roomlocation = { A: %s, B: %s, C: %s }</script>\n", getA(coords), getB(coords), getC(coords))
	
	# for (i=0; i<roomcnt; ++i) {
	# 	gencoords(i);

	# 	outdir = outdir pathents[i]

	# 	printf "outdir: %s\n", outdir

	# 	ensuredir=sprintf("mkdir -p %s\n", outdir)
	# 	system(ensuredir)
	
	# 	outfile = outdir "/index.html"
	# 	headercmd=sprintf("echo '%s' > %s", headerfile, outfile)
	# 	system(headercmd)

	# 	navcmd=sprintf("echo '%s' >> %s", navfile, outfile)
	# 	system(navcmd)
		
	# 	type=typeents[i]
	# 	switch (type) {
	# 	case "info":
	# 		printf "[CONSTRUCT info %s]\n", navents[i]
	# 		contentcmd=sprintf("cat %s.md | pandoc -f markdown >> %s", navents[i], outfile);
	# 		system(contentcmd);
	# 		break;
	# 	default:
	# 		printf "WHAT IS GOING ON AHHHH"
	# 	}
	# }
