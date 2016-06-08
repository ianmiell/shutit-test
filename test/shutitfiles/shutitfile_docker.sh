#!/bin/bash
set -e
set -x
rm -rf /tmp/asd
pushd ..
shutit skeleton \
	--shutitfiles 3/shutitfile_docker/Dockerfile \
	--module_directory /tmp/asd \
	--module_name testing \
	--domain shutit.tk \
	--delivery docker \
	--template_branch docker 
pushd /tmp/asd/bin
./build.sh
popd
popd
