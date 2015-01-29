for file in  pltosout.bin.*
do
    tlevel="${file##*.}"
    if [ ! -f ./GENPLIF_$tlevel.DAT ];
    then
      cp $file  pltosout.bin
      genplif tecplot < genplif.opt
      surftec < genplif.opt        
      mv GENPLIF.DAT gridbeton_field_$tlevel.tec
      mv SURFTEC.DAT gridbeton_surf_$tlevel.tec
    else
	echo "skipping  $file"
    fi
#    genplif ensight < genplif.opt		
#    rename ensight ensight_$tlevel ensight.*
done
