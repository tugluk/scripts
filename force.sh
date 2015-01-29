#!/bin/bash
bold=`tput bold`
normal=`tput sgr0`

source /opt/METACOMP/amd64/mcfdenv.sh

evocDir=$(pwd)

# for dir in Mach_*
# do
#     if [ -f "$dir".{temp,out} ]
#     then
# 	echo "Removing old files"
# 	rm "$dir".{temp,out}
#     fi
# done

rm Mach*.{out,temp}

for dir in Mach_*
do
    cd $dir
    	Mach="${dir##*_}"
	echo $bold $Mach $normal
    for subdir in AOA*
    do
	cd $subdir
	AOA="${subdir##*_}"
#	echo $AOA
	/opt/METACOMP/amd64/mlib/mcfd.12.1/exec/infout1r &> /dev/null 
	tail -n +13 minfo1_e1 > forces_out.dat
#	tail -"$1" forces_out.dat |awk -v aa=$AOA '{{printf aa " "} for (i=1;i<=NF;i++){a[i]+=$i}}END{for (i=1;i<=NF;i++){printf a[i]/(NR)" "};printf "\n"}' >> "$evocDir"/"$dir".temp
	tail -"$1" forces_out.dat |awk -v aa=$AOA '{for (i=1;i<=NF;i++){a[i]+=$i}}END{printf aa " "; for (i=1;i<=NF;i++){printf a[i]/(NR)" "};printf "\n"}' >> "$evocDir"/"$dir".temp
	
#	awk '{ sum += $3 } END { if (NR > 0) print sum / NR }' forces_out.dat
#	echo $dir/$subdir
#	tail -"$1" forces_out.dat |awk -v aa=$AOA '{print aa "\t"}'
	cd ..
    done

    sort -n < "$evocDir"/"$dir".temp > "$evocDir"/"$dir".out
    rm "$evocDir"/"$dir".temp
    cd ..
done


