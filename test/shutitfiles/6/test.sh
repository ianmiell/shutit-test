#!/bin/bash
set -e
set -x
rm -rf /tmp/asd
coverage run $(which shutit) skeleton \
	--shutitfiles Dockerfile1 \
	--name /tmp/asd \
	--domain shutit.tk \
	--delivery bash \
	--pattern bash
pushd /tmp/asd
./run.sh "$@"
popd
