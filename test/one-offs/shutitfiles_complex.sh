#!/bin/bash
set -e
set -x
rm -rf /tmp/asd
pushd ..
/space/git/shutit/shutit skeleton \
	--shutitfiles shutitfiles/2/shutitfile_complex/ShutItFile \
	              shutitfiles/2/shutitfile_complex/ShutItFile2 \
	--module_directory /tmp/asd \
	--module_name testing \
	--domain shutit.tk \
	--delivery bash \
	--template_branch bash
pushd /tmp/asd
#./run.sh -l debug
./run.sh
popd
popd
