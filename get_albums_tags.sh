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

ls "$DIR" | while read album_dir;
do
	file=`ls "$DIR/$album_dir" | grep .flac | head -n1`
	IMPORT_TAG_FILE=$DIR/$album_dir"_tag.txt"
	file="$DIR/$album_dir/$file"
	make get-metatag FILE="$file" IMPORT_TAG_FILE="${DIR}/${album_dir}_tags.txt"
done
