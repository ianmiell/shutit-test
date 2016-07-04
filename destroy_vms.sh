#!/bin/bash
if [[ $(command -v VBoxManage) != '' ]]
then
	while true 
	do
		VBoxManage list runningvms | grep shutit_test | awk '{print $1}' | xargs -IXXX VBoxManage controlvm 'XXX' poweroff && VBoxManage list vms | grep shutit_test | awk '{print $1}'  | xargs -IXXX VBoxManage unregistervm 'XXX' --delete
		if [[ $(VBoxManage list vms | grep shutit_test | wc -l) -eq '0' ]]
		then
			break
		else
			ps -ef | grep virtualbox | grep shutit_test | awk '{print $2}' | xargs kill
			sleep 10
		fi
	done
fi
