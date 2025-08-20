#!/bin/bash
if [ $# -lt 2 ]; then
    echo "No Parameters !!!!"
    echo "Usage: ./build_hotupdate.sh 1.0.0 ./zhenlongjiangshi"
else
    echo "-"
    echo "- build hotupdate"
    echo "- $1 ---->>>> $2"
    echo "-"
    echo "- Lua Scripts"
    echo "Press any key to continue ..."
    read -n 1
    echo "$2 $1 - `date "+%Y-%m-%d %H%M:%S"`" >> ./history
    rm -rf "$2/files_$1.txt"
    rm -rf "$1/hotupdatefiles/$1"
    FileCount=0
    TotalSize=0
    LUAFILES=`find ./hotupdate/scripts -name "*.*" -type f`
    for file in $LUAFILES
    do
        if [[ "$file" == *"README.md" ]]; then
            continue
        fi
        # echo $file
        FILEURL="scripts/"${file:20}
        echo $FILEURL
        echo $FILEURL >> ./history
        MD5STRING=`md5 $file | awk '{print $4}'`
        FILESIZE=`wc -c < $file`
        ((TotalSize+=$FILESIZE))
        ((FileCount+=1))
        printf -v RESULT "%s %s %s 1" "$FILEURL" "$MD5STRING" "$FILESIZE"
        echo $RESULT >> "$2/files_$1.txt"
        \cp -rf $file $2"/hotupdatefiles/scripts"
    done

    echo "-"
    echo "- Resources"
    echo "Press any key to continue ..."
    read -n 1
    LUAFILES=`find ./hotupdate/res -name "*.*" -type f`
    for file in $LUAFILES
    do
        if [[ "$file" == *"README.md" ]]; then
            continue
        fi
        # echo $file
        FILEURL="res/"${file:16}
        echo $FILEURL
        echo $FILEURL >> ./history
        MD5STRING=`md5 $file | awk '{print $4}'`
        FILESIZE=`wc -c < $file`
        ((TotalSize+=$FILESIZE))
        ((FileCount+=1))
        printf -v RESULT "%s %s %s 0" "$FILEURL" "$MD5STRING" "$FILESIZE"
        echo $RESULT >> "$2/files_$1.txt"
        DIRNMAE="${file%/*}"
        # echo "dir: $DIRNMAE"
        MDIR="${DIRNMAE:16}"
        # echo $MDIR
        if [[ "$MDIR" == "" ]]; then
            \cp -rf $file "$2/hotupdatefiles/res/$MDIR"
        else
            cd "$2/hotupdatefiles/res/"
            mkdir -p "$MDIR"
            cd "../../../"
            \cp -rf $file "$2/hotupdatefiles/res/$MDIR/"
        fi
        
    done
    echo "- Over"
    echo "---------------------------------------" >> ./history
    echo "Total $FileCount File" >> ./history
    echo "Total File Size: $TotalSize byte" >> ./history
    echo "---------------------------------------" >> ./history
    echo "" >> ./history
fi

