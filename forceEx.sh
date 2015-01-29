#!/bin/bash

#bcs=$(grep -A 24 "seq#" mcfd.inp|tail -n +2|awk '{print $1}')
#echo "$bcs"

for ibs in $(seq 1 24)
do
    echo $ibs 
    tempFile="$ibs".temp
    xForceFile=bc_"$ibs".x
    yForceFile=bc_"$ibs".y
    zForceFile=bc_"$ibs".z
    
#    echo "a"
    grep -A 5 "nbc = [[:blank:]] $ibs," mcfd.info1 |grep force > $tempFile
    grep "x force" $tempFile|awk '{print $3}' > $xForceFile
    grep "y force" $tempFile|awk '{print $3}' > $yForceFile
    grep "z force" $tempFile|awk '{print $3}' > $zForceFile
    
done
