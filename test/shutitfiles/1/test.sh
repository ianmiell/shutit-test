#!/bin/bash
set -e
set -x
rm -rf /tmp/asd
shutit skeleton \
	--shutitfiles ShutItFile \
	--name /tmp/asd \
	--domain shutit.tk \
	--delivery docker \
	--pattern docker
pushd /tmp/asd/bin
./test.sh "$@"
popd
