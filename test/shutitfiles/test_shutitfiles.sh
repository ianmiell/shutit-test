#!/bin/bash
set -e
set -x

rm -rf /tmp/asd
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

rm -rf /tmp/asd
shutit skeleton \
	--shutitfiles 2/shutitfile_complex/ShutItFile \
	              2/shutitfile_complex/ShutItFile2 \
	--module_directory /tmp/asd \
	--module_name testing \
	--domain shutit.tk \
	--delivery bash \
	--template_branch bash
pushd /tmp/asd
./run.sh
popd

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
./build.sh
popd
