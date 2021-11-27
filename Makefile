all:
	cat template.fp | ./parse.awk	

.PHONEY: clean
clean:
	rm -rf foobar
