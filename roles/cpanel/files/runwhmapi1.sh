#!/usr/bin/env bash
echo "Batch Start $1 - $(date)" >> $2/whmapicalls.log
while read i; do
        echo "Command: $i" >> $2/whmapicalls.log
        /usr/sbin/whmapi1 $i >> $2/whmapicalls.log
done < $2/$1
echo "Batch End - $(date)" >> $2/whmapicalls.log
rm -f $2/$1
