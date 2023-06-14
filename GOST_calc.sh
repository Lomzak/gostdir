#!/bin/bash
dir_for_report="Etalon"
if test -d $dir_for_report;then rm -r $dir_for_report;mkdir $dir_for_report;else mkdir $dir_for_report;fi

#if test -f filelist.txt;then rm filelist.txt;fi
declare -a file_list
readarray file_list < <(find . -type f -print)

result_2012_512="GOST_34.11-2012(512).txt"
result_2012_256="GOST_34.11-2012(256).txt"
result_1994_256="GOST_34.11-1994(256).txt"

echo -e "------------------------------------------------------GOST 34.11-2012(512)------------------------------------------------------\n" >> $result_2012_512
echo -e "------------------------------------------------------GOST 34.11-2012(256)------------------------------------------------------\n" >> $result_2012_256
echo -e "----------------------------------------------------------GOST 34.11-94---------------------------------------------------------\n" >> $result_1994_256

for var in "${!file_list[@]}"
do
sudo gostsum --gost-2012-512    ${file_list[$var]} >> $result_2012_512
sudo gostsum --gost-2012        ${file_list[$var]} >> $result_2012_256
sudo gostsum --gost-94          ${file_list[$var]} >> $result_1994_256
echo -e "------------------------------------------------------------------------------------------------------------------------------------\n" | tee -a $result_2012_512 $result_2012_256 $result_1994_256 > /dev/null
done

echo -e "\n===================================================================================================================================" | tee -a $result_2012_512 $result_2012_256 $result_1994_256 > /dev/null
mv $result_2012_256 $result_2012_512 $result_1994_256 $dir_for_report