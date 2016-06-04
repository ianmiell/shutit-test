#!/bin/bash
set -e
set -x
rm -rf /tmp/asd
pushd ..
shutit skeleton \
	--shutitfiles test/shutitfile_complex/ShutItFile \
	test/shutitfile_complex/ShutItFile2 \
	--module_directory /tmp/asd \
	--module_name testing \
	--domain shutit.tk \
	--delivery bash \
	--template_branch bash
pushd /tmp/asd
./run.sh -l debug
popd
popd
