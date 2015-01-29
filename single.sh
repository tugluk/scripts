#!/bin/bash

tlevel=$1

file=pltosout.bin.$tlevel

echo "Processing" $file
if [ ! -f ./GENPLIF_$tlevel.DAT ];
then
    cp $file  pltosout.bin
    genplif tecplot < genplif.opt &>/dev/null
    surftec < genplif.opt &>/dev/null       
    mv GENPLIF.DAT gridbeton_field_$tlevel.tec
    mv SURFTEC.DAT gridbeton_surf_$tlevel.tec
else
    echo "skipping  $file"
fi

