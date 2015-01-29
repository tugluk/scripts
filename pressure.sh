#!/bin/bash
bold=`tput bold`
normal=`tput sgr0`

source /opt/METACOMP/amd64/mcfdenv.sh

evocDir=$(pwd)
outFile=$evocDir/kenan_test.dat

bcFileName=BC1.txt

if [[ -e $outFile ]]
    then
    rm $outFile
fi


for dir in Mach_*
do
    if [[ -d $dir ]]
    then
	cd $dir
    	Mach="${dir##*_}"
	echo $bold $Mach $normal
	for subdir in AOA*
	do
	    cd $subdir
	    AOA="${subdir##*_}"
	    echo  $AOA
	    echo  $Mach >> $outFile
	    echo  $AOA >> $outFile
	    tail -n +2 $bcFileName |awk '{print $1 $2 $3 $4}' >> $outFile
	    cd ..
	done
	cd ..
    fi
done

