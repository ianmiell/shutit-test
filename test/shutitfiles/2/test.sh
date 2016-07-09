#!/bin/bash
set -e
#set -x
rm -rf /tmp/asd
shutit skeleton \
	--shutitfiles ShutItFile ShutItFile2 \
	--name /tmp/asd \
	--domain shutit.tk \
	--delivery bash \
	--template_branch bash
pushd /tmp/asd
#./run.sh -l debug
./run.sh "$@"
popd
