#!/bin/bash

for x in `cat $list`
do
	ipmi_install()
    {
    	scp $tool root@$x:/tmp 
        ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null root@$x "esxcli software acceptance set --level=CommunitySupported"
        ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null root@$x "esxcli software vib install -v $tool"
        ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null root@$x "esxcli software acceptance set --level=PartnerSupported"
        ### 建立軟連結以方便呼叫
        ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null root@$x "ln -s /opt/ipmitool/ipmitool /ipmitool"
        echo "===== $x Installed ====="
    }
	
    chk=`ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null root@$x "esxcli software vib list" |grep -i 'ipmitool'`
    [[ "$chk" ]] && echo "===== $x Deployed =====" || ipmi_install
done


