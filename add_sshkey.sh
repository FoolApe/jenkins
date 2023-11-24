#!/bin/bash
for x in `cat $list`
do
	function add_key()
    {
        sshpass -f $pass scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null $new_key root@$x:/tmp ### 把pub_key丟到ESXi上 ###
        sshpass -f $pass ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null root@$x "cat /tmp/newkey |grep 'VM_NAME' >> $real_key" ### 將pub_key加到/etc/ssh/keys-root/authorized_keys內 ###
        sshpass -f $pass ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null root@$x "cat $real_key |grep 'VM_NAME'" ### 檢查用 ###
    }
    add_key
done
