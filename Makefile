all:
	./hubify.sh Test.truck

u:
	./hubify.sh Underground.truck

r:
	./hubify.sh -d Rosetta.truck || true
	rm -rf Rosetta.truck
	cp -r ~/rosetta/Rosetta.truck .
	./hubify.sh Rosetta.truck

.PHONEY: clean uc all u
clean:
	./hubify.sh -d Test.truck
uc:
	./hubify.sh -d Underground.truck
