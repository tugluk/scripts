for file in  $@
do
    echo $file
    
    tlevel="${file##*.}"
    
    npfcutpl x= 3.576 cellsin.bin $file mpf level_$tlevel &>/dev/null
    mpf3dtecp cut_level_$tlevel.mpf3d cut_$tlevel.dat &>/dev/null

done
