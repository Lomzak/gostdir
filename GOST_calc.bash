#!/bin/bash
dir_for_report="gostdir_Etalon"
if test -d $dir_for_report;then rm -r $dir_for_report;mkdir $dir_for_report;else mkdir $dir_for_report;fi

declare -a file_list GOST_HASH_2012_512 GOST_HASH_2012_256 GOST_HASH_1994_256
readarray file_list < <(find . -type f -print)

report="Report.html"
cat << EOF >> "$report"
<html>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<head>
	<style type="text/css">
		.table {background-color : white; font-size : 11px;}
		.tableTop {background-color : #DFDFDF; font-weight : bold;}
		.filename {font-family: 'Times New Roman', Times, serif;}
		.hash {font-family : Courier New,Tahoma, Verdana, Geneva, Arial, Helvetica, sans-serif;}
		.tableBottom {background-color : #FFE0E0; font-weight : bold;}
		.Path {background-color : #F4F4F4; font-weight : bold;font-family : Courier New,Tahoma, Verdana, Geneva, Arial, Helvetica, sans-serif;}
	</style>
</head>
<body>
<title>Gostdir REPORT</title>
<center><caption><BIG><B>ОТЧЁТ<br>о фиксации исходного состояния<br>__________________________________________________________<br>(GOST 34.11-2012(512), GOST 34.11-2012(256),GOST 34.11-94)</B></BIG></caption></center>
<BR>
<table BORDER=3 width="100%" cellspacing="1" cellpadding="1" style= "BORDER-COLLAPSE: collapse">
<tr>
<td class="tableTop" ALIGN=CENTER>№ пп</td>
<td class="tableTop" ALIGN=CENTER>Имя файла</td>
<td class="tableTop" ALIGN=CENTER>GOST 34.11-2012(512)</td>
</tr>
EOF

for var in "${!file_list[@]}"
do
GOST_HASH_2012_512[$var]="$(sudo gostsum --gost-2012-512    ${file_list[$var]}| sed -r 's/ .+//')"
GOST_HASH_2012_256[$var]="$(sudo gostsum --gost-2012        ${file_list[$var]}| sed -r 's/ .+//')"
GOST_HASH_1994_256[$var]="$(sudo gostsum --gost-94          ${file_list[$var]}| sed -r 's/ .+//')"
done

for var in "${!file_list[@]}"
do
list_number=$((var+1))
echo '<tr>' >> $report
echo "<td ALIGN=CENTER>$(echo "$list_number")</td>" >> "$report"
echo "<td class="filename" >$(echo "${file_list[$var]}")</td>" >> $report
echo "<td class="hash" ALIGN=CENTER>$(echo "${GOST_HASH_2012_512[$var]}")</td>" >> $report
echo '</tr>' >> $report
done
echo '</table>' >> $report
echo '<BR>' >> $report
echo '<BR>' >> $report

cat << EOF >> "$report"
<table BORDER=3 width="100%" cellspacing="1" cellpadding="1" style= "BORDER-COLLAPSE: collapse">
<tr>
<td class="tableTop" ALIGN=CENTER>№ пп</td>
<td class="tableTop" ALIGN=CENTER>Имя файла</td>
<td class="tableTop" ALIGN=CENTER>GOST 34.11-2012(256)</td>
</tr>
EOF

for var in "${!file_list[@]}"
do
list_number=$((var+1))
echo '<tr>' >> $report
echo "<td ALIGN=CENTER>$(echo "$list_number")</td>" >> "$report"
echo "<td class="filename" >$(echo "${file_list[$var]}")</td>" >> $report
echo "<td class="hash" ALIGN=CENTER>$(echo "${GOST_HASH_2012_256[$var]}")</td>" >> $report
echo '</tr>' >> $report
done
echo '</table>' >> $report
echo '<BR>' >> $report
echo '<BR>' >> $report

cat << EOF >> "$report"
<table BORDER=3 width="100%" cellspacing="1" cellpadding="1" style= "BORDER-COLLAPSE: collapse">
<tr>
<td class="tableTop" ALIGN=CENTER>№ пп</td>
<td class="tableTop" ALIGN=CENTER>Имя файла</td>
<td class="tableTop" ALIGN=CENTER>GOST 34.11-1994(256)</td>
</tr>
EOF

for var in "${!file_list[@]}"
do
list_number=$((var+1))
echo '<tr>' >> $report
echo "<td ALIGN=CENTER>$(echo "$list_number")</td>" >> "$report"
echo "<td class="filename" >$(echo "${file_list[$var]}")</td>" >> $report
echo "<td class="hash" ALIGN=CENTER>$(echo "${GOST_HASH_1994_256[$var]}")</td>" >> $report
echo '</tr>' >> $report
done
echo '</table>' >> $report


mv $report $dir_for_report