#!/bin/bash
set -e
set -x
rm -rf /tmp/asd
shutit skeleton \
	--shutitfiles ShutItFile \
	--module_directory /tmp/asd \
	--module_name testing \
	--domain shutit.tk \
	--delivery docker \
	--template_branch docker
pushd /tmp/asd/bin
./test.sh "$@"
popd
