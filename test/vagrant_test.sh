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

#!/bin/bash
if [[ $(command -v VBoxManage) != '' ]]
then
    while true
    do
        VBoxManage list runningvms | grep shutit_testing_ | awk '{print $1}' | xargs -IXXX VBoxManage controlvm 'XXX' poweroff && VBoxManage list vms | grep shutit_testing_ | awk '{print $1}'  | xargs -IXXX VBoxManage unregistervm 'XXX' --delete
        # The xargs removes whitespace
        if [[ $(VBoxManage list vms | grep shutit_testing_ | wc -l | xargs) -eq '0' ]]
        then
            break
        else
            ps -ef | grep virtualbox | grep shutit_testing_ | awk '{print $2}' | xargs kill
            sleep 10
        fi
    done
fi

# Is Virtualbox on here? If not, exit 0.
if [[ ! 'command -v VBoxManage' ]]
then
	echo VBoxManage not available on this host, returning ok
	exit 0
fi

# Variables
NEWDIR=/tmp/shutit_testing_$$_$(hostname)_$(whoami)_$(date -I)_$(date +%N)
SHUTIT_DIR="$(pwd)"
readonly NEWDIR SHUTIT_DIR

set_shutit_options

# This is a fallback, any tests runnable on their own should include the below
if [[ $0 != vagrant_test.sh ]] && [[ $0 != ./vagrant_test.sh ]]
then
	echo "Must be run from dir of vagrant_test.sh"
	exit 1
fi

#PYTHONPATH=$(pwd) python test/test.py

if [[ $(which vagrant) != '' ]]
then
	DESC="Testing vagrant build basic bare"
	echo $DESC
	shutit skeleton --name ${NEWDIR} \
		--domain shutit.tk --depends shutit.tk.setup --base_image ubuntu:14.04 \
		--delivery bash --pattern vagrant
	pushd ${NEWDIR}
	chmod +x ./destroy_vms.sh
	./run.sh -l debug --echo
	if [[ "x$?" != "x0" ]]
	then
		echo "FAILED ON $DESC"
		cleanup hard
		exit 1
	fi
	cleanup hard
	popd
	rm -rf ${NEWDIR}
	
	
	DESC="Testing vagrant_multinode build basic bare"
	echo $DESC
	shutit skeleton --name ${NEWDIR} \
		--domain shutit.tk --depends shutit.tk.setup --base_image ubuntu:14.04 \
		--delivery bash --pattern vagrant_multinode
	pushd ${NEWDIR}
	chmod +x ./destroy_vms.sh
	./run.sh
	if [[ "x$?" != "x0" ]]
	then
		echo "FAILED ON $DESC"
		cleanup hard
		exit 1
	fi
	cleanup hard
	popd
	rm -rf ${NEWDIR}
	
	
	DESC="Testing docker_tutorial build basic bare"
	echo $DESC
	shutit skeleton --name ${NEWDIR} \
		--domain shutit.tk --depends shutit.tk.setup --base_image ubuntu:14.04 \
		--delivery docker --pattern docker_tutorial
	pushd ${NEWDIR}
	chmod +x ./destroy_vms.sh
	./run.sh
	if [[ "x$?" != "x0" ]]
	then
		echo "FAILED ON $DESC"
		cleanup hard
		exit 1
	fi
	popd
	rm -rf ${NEWDIR}

	for d in $(ls -d test/vagrant_tests/[0-9]* | sort -n)
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
				echo "================================================================================"
				echo "SHUTIT MODULE TEST $d: In directory: `pwd` BEGIN"
				echo "================================================================================"
				./run.sh
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
			fi
		fi
		report
		popd
	done

else
	echo "NO VAGRANT AVAILABLE TO TEST"
	exit 1
fi
