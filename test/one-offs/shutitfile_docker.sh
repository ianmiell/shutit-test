#!/bin/bash
set -e
set -x
rm -rf /tmp/asd
pushd ..
shutit skeleton \
	--shutitfiles shutitfiles/shutitfile_docker/Dockerfile \
	--module_directory /tmp/asd \
	--module_name testing \
	--domain shutit.tk \
	--delivery docker \
	--template_branch docker
pushd /tmp/asd/bin
#./run.sh -l debug
./build.sh
popd
popd
