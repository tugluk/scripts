fileIn=$1
awk 'NR%28==1{x="level"++i;}{print > x}'  $fileIn

for fileCurr in level*
do
    for ii in $(seq 1 28)
    do
	echo "awk 'NR == n' n=$ii $fileCurr >> point_$ii"
    done
done


for fileCurr in point_*
do
     tlevel="${fileCurr##*_}"
     echo $tlevel
    sort -n < $fileCurr > "probe_point_$tlevel.dat"
done
    