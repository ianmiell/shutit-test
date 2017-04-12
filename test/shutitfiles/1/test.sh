#!/bin/bash
set -e
set -x
rm -rf /tmp/asd
coverage run $(which shutit) skeleton \
	--shutitfiles ShutItFile \
	--name /tmp/asd \
	--domain shutit.tk \
	--delivery docker \
	--pattern docker
pushd /tmp/asd
./test.sh "$@"
popd
