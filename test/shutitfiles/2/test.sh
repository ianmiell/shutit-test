#!/bin/bash
set -e
#set -x
rm -rf /tmp/asd
coverage run -a $(which shutit) skeleton \
	--shutitfiles ShutItFile ShutItFile2 \
	--name /tmp/asd \
	--domain shutit.tk \
	--delivery bash \
	--pattern bash
pushd /tmp/asd
#./run.sh -l debug
./run.sh "$@"
popd
