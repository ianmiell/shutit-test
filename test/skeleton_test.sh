#!/bin/bash
# Copyright (C) 2014 OpenBet Limited
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy 
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

TESTS=${1:-basic}

pushd $(dirname ${BASH_SOURCE[0]})/.. > /dev/null 2>&1

#set -x

source test/shared_test_utils.sh

# Variables
NEWDIR=/tmp/shutit_testing_$$_$(hostname)_$(whoami)_$(date -I)_$(date +%N)
SHUTIT_DIR="$(pwd)"
readonly NEWDIR SHUTIT_DIR

set_shutit_options

# Check we can use docker
if ! $DOCKER info >/dev/null 2>&1; then
	echo "Failed to run docker! - used command \"$DOCKER info\" to check"
	false
fi

# This is a fallback, any tests runnable on their own should include the below
if [[ $0 != skeleton_test.sh ]] && [[ $0 != ./skeleton_test.sh ]]
then
	echo "Must be run from dir of test.sh"
	exit 1
fi

#PYTHONPATH=$(pwd) python test/test.py 

find ${SHUTIT_DIR} -name '*.cnf' | grep '/configs/[^/]*.cnf' | xargs chmod 600
cleanup hard


DESC="Testing skeleton build with Shutitfile"
echo $DESC
coverage run --parallel-mode --include="*shutit*" $(which shutit) skeleton --shutitfiles test/shutitfiles/1/ShutItFile --name ${NEWDIR} \
	--domain shutit.tk \
	--depends shutit.tk.setup --base_image ubuntu:14.04 --delivery docker \
	--pattern docker
pushd ${NEWDIR}
./test.sh --interactive 0 -l debug
if [[ "x$?" != "x0" ]]
then
	echo "FAILED ON $DESC: $?"
	cleanup hard
	exit 1
fi
cleanup hard
popd
rm -rf ${NEWDIR}

DESC="Testing skeleton build with two ShutItFiles"
echo $DESC
coverage run --parallel-mode --include="*shutit*" $(which shutit) skeleton \
	--shutitfiles test/shutitfiles/1/ShutItFile \
	--name ${NEWDIR} --domain shutit.tk \
	--depends shutit.tk.setup --base_image ubuntu:14.04 --delivery docker \
	--pattern docker
pushd ${NEWDIR}
./test.sh --interactive 0 -l debug
if [[ "x$?" != "x0" ]]
then
	echo "FAILED ON $DESC: $?"
	cleanup hard
	exit 1
fi
cleanup hard
popd
rm -rf ${NEWDIR}

# Must be run interactively
#DESC="Testing skeleton build with two complex ShutItFiles"
#echo $DESC
#shutit skeleton \
#	--shutitfiles \
#		test/shutitfile_complex/ShutItFile test/shutitfile_complex/ShutItFile2 \
#	--name ${NEWDIR} --domain shutit.tk \
#	--delivery bash --pattern bash
#pushd ${NEWDIR}
#./run.sh
#if [[ "x$?" != "x0" ]]
#then
#	echo "FAILED ON $DESC: $?"
#	cleanup hard
#	exit 1
#fi
#cleanup hard
#popd
#rm -rf ${NEWDIR}

DESC="Testing skeleton build basic bare"
echo $DESC
coverage run --parallel-mode --include="*shutit*" $(which shutit) skeleton --name ${NEWDIR} \
	--domain shutit.tk --depends shutit.tk.setup --base_image ubuntu:14.04 \
	--delivery docker --pattern docker
pushd ${NEWDIR}
./test.sh --interactive 0 -l debug
if [[ "x$?" != "x0" ]]
then
	echo "FAILED ON $DESC"
	cleanup hard
	exit 1
fi
cleanup hard
popd
rm -rf ${NEWDIR}


DESC="Testing skeleton build basic with example script"
echo $DESC
coverage run --parallel-mode --include="*shutit*" $(which shutit) skeleton --name ${NEWDIR} \
	--domain shutit.tk --depends shutit.tk.setup --base_image ubuntu:14.04 \
	--script assets/example.sh --delivery docker \
	--pattern docker

pushd ${NEWDIR}
./test.sh --interactive 0 -l debug
if [[ "x$?" != "x0" ]]
then
	echo "FAILED ON $DESC"
	cleanup hard
	exit 1
fi
cleanup hard
popd
rm -rf ${NEWDIR}

popd > /dev/null 2>&1
# OK
echo "SHUTIT TEST OK"
exit

