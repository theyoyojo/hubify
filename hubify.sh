#!/bin/bash

usage() {
	echo "${0} <truck location>"
}

echo "[HUBIFY HELLO]"

DEMOLISH=
if [ -z ${1} ]; then
	usage
	exit 0
fi

while getopts "dh" OPTION; do
	case ${OPTION} in
		d)
			DEMOLISH=yes
			;;
		h)
			usage
			;;
	esac
done
shift "$((OPTIND - 1))"


TRUCK=${1}
FLOORPLAN=$(ls $TRUCK | grep ".*\.fp")

if [ -z ${FLOORPLAN} ]; then
	echo "[FATAL no plan!]"
	exit 1
fi

echo "[FLOORPLAN ${FLOORPLAN}]"

HOUSE=$(cat ${TRUCK}/${FLOORPLAN} | awk '!/#/ && /House/ {for (i=2; i<=NF; ++i) {house = house $i;} print house}')

if [ ! -z ${DEMOLISH} ]; then
	echo "[DEMOLISH HOUSE ${HOUSE}]"
	rm -rf ${HOUSE}.yard
	rm -rf ${HOUSE}
	rm -rf House
	exit
fi

echo "[BUILD BEGINS]"
cat ${TRUCK}/${FLOORPLAN} | ./unload.awk
cat ${HOUSE}.yard/coordinator | ./coordinate.awk

mkdir -p ${HOUSE}
ROOMS=$(ls ${HOUSE}.yard | grep "\.room$")

for room in ${ROOMS}; do
	cat ${HOUSE}.yard/${room} | ./construct.awk
done


ASSETS=$(ls ${HOUSE}.yard | grep "\.asset$")
for asset in ${ASSETS}; do
	echo ${asset} | ./decorate.awk
done

echo "[BUILD COMPLETE]"
echo "[HUBIFY GOODBYE]"
