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
    LUAFILES=`find ./hotupdate/scripts -name "*.*" -type f`
    for file in $LUAFILES
    do
        if [[ "$file" == *"README.md" ]]; then
            continue
        fi
        echo $file
        FILEURL="scripts/"${file:20}
        echo $FILEURL
        MD5STRING=`md5 $file | awk '{print $4}'`
        FILESIZE=`wc -c < $file`
        printf -v RESULT "%s %s %s 1" "$FILEURL" "$MD5STRING" "$FILESIZE"
        echo $RESULT >> "$2/files_$1.txt"
        \cp -rf $file $2"/files/scripts"
    done

    echo "-"
    echo "- Resources"
    echo "Press any key to continue ..."
    read -n 1
    LUAFILES=`find ./hotupdate/res -name "*.*" -type f`
    for file in $LUAFILES
    do
        echo $file
        # if [[ "$file" == *"README.md" ]]; then
        #     continue
        # fi
        # echo $file
        # FILEURL="res/"${file:16}
        # echo $FILEURL
        # MD5STRING=`md5 $file | awk '{print $4}'`
        # FILESIZE=`wc -c < $file`
        # printf -v RESULT "%s %s %s 1" "$FILEURL" "$MD5STRING" "$FILESIZE"
        # echo $RESULT >> "$2/files_$1.txt"
        FILEURL="${file:16}"
        DIRNMAE="${FILEURL%/*}"
        echo $DIRNMAE
        mkdir -p "$2/hotupdatefiles/res/$DIRNMAE"
        \cp -rf $file "$2/hotupdatefiles/res/$DIRNMAE/"
    done
    echo "- Over"
    # echo "Press any key to continue ..."
    # read -n 1
fi

