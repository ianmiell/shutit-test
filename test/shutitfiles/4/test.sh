#!/bin/bash
set -e
set -x
rm -rf /tmp/asd
coverage run --parallel-mode --include="*shutit*" $(which shutit) skeleton \
	--shutitfiles Dockerfile1 Dockerfile2 \
	--name /tmp/asd \
	--domain shutit.tk \
	--delivery docker \
	--pattern docker
pushd /tmp/asd
./build.sh "$@"
popd
