#!/bin/bash
set -e
set -x
rm -rf /tmp/asd
shutit skeleton \
	--shutitfiles Dockerfile \
	--module_directory /tmp/asd \
	--module_name testing \
	--domain shutit.tk \
	--delivery docker \
	--template_branch docker 
pushd /tmp/asd/bin
./build.sh "$@"
popd
