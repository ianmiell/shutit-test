#!/bin/bash
set -e
set -x
rm -rf /tmp/asd
shutit skeleton \
	--shutitfiles 4/shutitfile_docker_complex/Dockerfile1 \
	              4/shutitfile_docker_complex/Dockerfile2 \
	--module_directory /tmp/asd \
	--module_name testing \
	--domain shutit.tk \
	--delivery docker \
	--template_branch docker
pushd /tmp/asd/bin
./build.sh -l debug
popd
