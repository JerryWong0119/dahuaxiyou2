#!/bin/bash
echo "-"
echo "- build hotupdate"
echo 按任意键继续
read -n 1
echo "- $1"
LUAFILES=`find ./hotupdate/scripts -name "*.*" -type f`
for file in $LUAFILES
do
    FILEURL="scripts/"${file:20}
    MD5STRING=`md5 $file | awk '{print $4}'`
    FILESIZE=`wc -c < $file`
    printf -v RESULT "%s %s %s 1" "$FILEURL" "$MD5STRING" "$FILESIZE"
    echo $RESULT >> "files_$1.txt"
done