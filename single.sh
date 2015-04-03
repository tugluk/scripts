#!/bin/bash

tlevel=$1

file=pltosout.bin.$tlevel

echo "Processing" $file
if [ ! -f ./GENPLIF_$tlevel.dat ];
then
    cp $file  pltosout.bin
    genplif tecplot < genplif.opt &>/dev/null
    surftec < genplif.opt &>/dev/null       
    mv GENPLIF.DAT GENPLIF_$tlevel.dat
    mv SURFTEC.DAT surf_$tlevel.dat
else
    echo "skipping  $file"
fi

