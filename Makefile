all:
	./hubify.sh Test.truck

u:
	./hubify.sh Underground.truck

.PHONEY: clean uc all u
clean:
	./hubify.sh -d Test.truck
uc:
	./hubify.sh -d Underground.truck
