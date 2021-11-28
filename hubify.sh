#!/bin/bash

usage() {
	echo "${0} <truck location>"
}

echo "[HUBIFY]"

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

if [ ! -z ${DEMOLISH} ]; then
	HOUSE=$(cat ${TRUCK}/${FLOORPLAN} | awk '!/#/ && /House/ {for (i=2; i<=NF; ++i) {house = house $i;} print house}')
	echo "[DEMOLISH HOUSE ${HOUSE}]"
	rm -rf ${HOUSE}.yard
	rm -rf ${HOUSE}
	exit
fi

echo "[BUILD BEGINS]"
cat ${TRUCK}/${FLOORPLAN} | ./parse.awk
