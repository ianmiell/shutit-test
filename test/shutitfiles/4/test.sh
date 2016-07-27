#!/bin/bash
set -e
set -x
rm -rf /tmp/asd
shutit skeleton \
	--shutitfiles Dockerfile1 Dockerfile2 \
	--name /tmp/asd \
	--domain shutit.tk \
	--delivery docker \
	--pattern docker
pushd /tmp/asd/bin
./build.sh "$@"
popd
