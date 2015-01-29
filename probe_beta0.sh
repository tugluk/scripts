#!/bin/bash 

outFile=lump_probe_output.dat
workDir=$(pwd)
if [ -f $outFile ]
then
    mv   $outFile  $outFile.bak
fi



#beta=0
    for alphaDir in AOA_*
    do
	cd $alphaDir
	AOA="${alphaDir##*_}"

	for betaDir in SSA_*
	do
	    
	    cd $betaDir
	    beta="${betaDir##*_}"
	    
	    
	    cp $workDir/xyzlist.dat ./
	    toactran3 xyzlist.dat probe_output.dat pltosout.bin  U V W  &>/dev/null
	    tail -n +3  probe_output.dat | awk -v a=$AOA -v b=$beta '{print b, a, $0}'   >> $workDir/$outFile
	    cd ..
	done
	cd ..
    done
# sort -n < probe_output > $outFile
 rm probe_output*

