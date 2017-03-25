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

set -x

source test/shared_test_utils.sh

# Variables
NEWDIR=/tmp/shutit_testing_$$_$(hostname)_$(whoami)_$(date -I)_$(date +%N)
SHUTIT_DIR="$(pwd)"
readonly NEWDIR SHUTIT_DIR

set_shutit_options

# This is a fallback, any tests runnable on their own should include the below
if [[ $0 != bash_test.sh ]] && [[ $0 != ./bash_test.sh ]]
then
	echo "Must be run from dir of bash_test.sh"
	exit 1
fi

#PYTHONPATH=$(pwd) python test/test.py 

find ${SHUTIT_DIR} -name '*.cnf' | grep '/configs/[^/]*.cnf' | xargs chmod 600
cleanup hard

mkdir -p /tmp/shutit_logs/$$
declare -A PIDS
PIDS=()
for d in $(ls -d test/bash_tests/[0-9]* | sort -n)
do
	[ -d ${SHUTIT_DIR}/$d ] || continue
	pushd ${SHUTIT_DIR}/$d
	if [[ -a STOPTEST ]]
	then
		echo "STOPTEST file found in $(pwd)"
	else 
		if [[ -a /tmp/SHUTITSTOPTEST ]]
		then
			echo "/tmp/SHUTITSTOPTEST file found in /tmp"
		else
			# Must be done on each iteration as we need a fresh cid per test run
			set_shutit_options "-d bash --interactive 0 --imageerrorok"
			echo "================================================================================"
			echo "SHUTIT MODULE TEST $d: In directory: `pwd` BEGIN"
			echo "================================================================================"
			./test.sh --interactive 0 -l debug
			RES=$?
			if [[ "x$RES" != "x0" ]]
			then
				echo "FAILURE |$RES| in: $(pwd) running test.sh"
				cleanup hard
				exit 1
			fi
			cleanup hard
			echo "================================================================================"
			echo "SHUTIT MODULE TEST $d: In directory: `pwd` END"
			echo "================================================================================"
			set_shutit_options
		fi
	fi
	report
	popd
done


report
cleanup hard

popd > /dev/null 2>&1
# OK
echo "SHUTIT TEST OK"
exit

