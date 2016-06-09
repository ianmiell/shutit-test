#!/bin/bash
set -e
set -x
rm -rf /tmp/asd
/space/git/shutit/shutit skeleton \
	--shutitfiles ShutItFile ShutItFile2 \
	--module_directory /tmp/asd \
	--module_name testing \
	--domain shutit.tk \
	--delivery bash \
	--template_branch bash
pushd /tmp/asd
#./run.sh -l debug
./run.sh "$@"
popd
