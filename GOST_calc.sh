#!/bin/bash
dir_for_report="Etalon"
if test -d $dir_for_report;then rm -r $dir_for_report;mkdir $dir_for_report;else mkdir $dir_for_report;fi
if test -f filelist.txt;then rm filelist.txt;fi

find . -type f -print | sort >> temp.txt
filelist="filelist.txt";temp="temp.txt"
sed -e '/temp.txt/d' -e '/GOST_calc.sh/d' $temp >> $filelist
rm $temp

result_2012_512="GOST_34.11-2012(512).txt"
result_2012_256="GOST_34.11-2012(256).txt"
result_94="GOST_34.11-94.txt"
echo -e "------------------------------------------------------GOST 34.11-2012(512)------------------------------------------------------\n" >> $result_2012_512
echo -e "------------------------------------------------------GOST 34.11-2012(256)------------------------------------------------------\n" >> $result_2012_256
echo -e "----------------------------------------------------------GOST 34.11-94---------------------------------------------------------\n" >> $result_94

for var in $(cat $filelist)
do
sudo gostsum --gost-2012-512 $var >> $result_2012_512
sudo gostsum --gost-2012 $var >> $result_2012_256
sudo gostsum --gost-94 $var >> $result_94
echo -e "------------------------------------------------------------------------------------------------------------------------------------\n" | tee -a $result_2012_512 $result_2012_256 $result_94 > /dev/null
done

rm $filelist

echo -e "\n===================================================================================================================================" | tee -a $result_2012_512 $result_2012_256 $result_94 > /dev/null
mv $result_2012_256 $result_2012_512 $result_94 $dir_for_report
