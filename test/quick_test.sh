#!/bin/bash
for d in [0-9]*
do
	if [[ $d = 14 ]]
	then
		continue
	fi
	echo $d
	pushd $d/bin
	./test.sh "$@"
	RES=$?
	echo $RES
	if [[ $RES != 0 ]]
	then
		echo FAILED
		exit 1
	fi
	popd
done
