all:
	cat template.fp | ./parse.awk	
	cat $(shell cat House).coords | ./coordinator.awk >> foobar/x/index.html

.PHONEY: clean
clean:
	rm -rf foobar
	rm -rf $(shell cat House).coords
	rm -rf House
