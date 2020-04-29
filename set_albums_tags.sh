#!/bin/bash

DIR=""

while getopts d: OPT
do
    case $OPT in
        d)  DIR=$OPTARG
            ;;
        \?) exit 1
            ;;
    esac
done


ls "$DIR" | grep -v .txt | while read album_dir;
do
	make set-all-tag ALBUM_DIR="$DIR/$album_dir" IMPORT_TAG_FILE="${DIR}/${album_dir}_tags.txt"
done
