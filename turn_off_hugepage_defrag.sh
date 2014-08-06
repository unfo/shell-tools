#!/bin/bash
#
### Turn off Redhat hugepage defragmenting
#
# Authors: jw / 2013-12-13
# 		   jw / 2014-06-24 # disable hugepage on boot + new CentOS versions 

release=`cat /etc/redhat-release | egrep -Eo '6\.[0-5]'`

if [ "$release" != "" ]; then
	cat /sys/kernel/mm/redhat_transparent_hugepage/khugepaged/defrag
	cat /sys/kernel/mm/redhat_transparent_hugepage/defrag 
	cat /etc/rc.local


	echo no    | sudo tee /sys/kernel/mm/redhat_transparent_hugepage/khugepaged/defrag
	fgrep /sys/kernel/mm/redhat_transparent_hugepage/khugepaged/defrag /etc/rc.local > /dev/null || echo "echo no > /sys/kernel/mm/redhat_transparent_hugepage/khugepaged/defrag" | sudo tee -a /etc/rc.local
	

	echo never | sudo tee /sys/kernel/mm/redhat_transparent_hugepage/defrag
	fgrep /sys/kernel/mm/redhat_transparent_hugepage/defrag /etc/rc.local  > /dev/null || echo "echo never > /sys/kernel/mm/redhat_transparent_hugepage/defrag" | sudo tee -a /etc/rc.local


	cat /sys/kernel/mm/redhat_transparent_hugepage/khugepaged/defrag
	cat /sys/kernel/mm/redhat_transparent_hugepage/defrag 
	cat /etc/rc.local
fi