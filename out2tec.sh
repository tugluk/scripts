#!/bin/bash

fullfile=$1
filename=$(basename "$fullfile")

fileBaseName="${filename%.*}"
fileExtension="${filename##*.}"
fileTecplotName="$fileBaseName".dat

Mach="${fileBaseName##*_}"
MachZone="M"$(echo $Mach|awk -F "." '{print $1$2}')


cat -n "$fullfile" > tempFile

awk -v mmach=$Mach '{$1=mmach}1'  tempFile > temp2File
awk  'BEGIN{OFS="  \t "} {print $1,$2,$(NF-1),$(NF),$(NF-2),$(NF-1)/$(NF)}'  temp2File  > tempFile

header="VARIABLES= M Alpha Cl Cd Cm Cl/Cd"

echo -e $header > "$fileTecplotName"
header="ZONE T =$MachZone"
echo -e $header >>  "$fileTecplotName"
cat tempFile >>  "$fileTecplotName"

echo $fileTecplotName
echo $MachZone