#!/bin/bash 
# xyzlist.dat: points to probe
# probe_output.datprobe_output.dat : outputfile
# variable names
outFile=lump_probe_output.dat
#outFile=$1
npoints=$1

shift
fileList=$@

#echo $fileList


if [ -f $outFile ]
then
    mv   $outFile  $outFile.bak
fi

for file in $fileList
do
    tlevel="${file##*.}"
    toactran3 xyzlist.dat probe_output_$tlevel.dat $file U V W P &>/dev/null
    tail -n +3  probe_output_$tlevel.dat | awk -v varT=$tlevel '{print varT, $0}'  >> probe_output
done

 sort -n < probe_output > $outFile
 rm probe_output*

fileIn=$outFile

awk -v nn=$npoints 'NR%nn==1{x="level"++i;}{print > x}'  $fileIn

for fileCurr in level*
do
    for ii in $(seq 1 $npoints)
    do
	awk 'NR == n' n=$ii $fileCurr >> point_$ii
    done
done


for fileCurr in point_*
do
     tlevel="${fileCurr##*_}"
     echo $tlevel
    sort -n < $fileCurr > "probe_point_$tlevel.dat"
done

rm point_*    

return 0;
