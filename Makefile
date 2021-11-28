all:
	./hubify.sh Test.truck

.PHONEY: clean
clean:
	./hubify.sh -d Test.truck
