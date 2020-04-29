DIR=""
IMPORT_TAG_FILE="import_tag.txt"
TRACK=10


check:
	ls ${DIR} | while read file; do \
		echo $$file; \
		metaflac --list ${DIR}/"$$file"; \
		echo "";\
	done

set-all-tag: set-common-tag set-title set-track

set-common-tag:
	ls ${DIR} | while read file; do metaflac --remove-all-tags --import-tags-from=${IMPORT_TAG_FILE} ${DIR}/"$$file"; done

set-title:
	ls ${DIR} | while read file; \
	do \
		title=`echo $$file | sed -e "s/[0-9]*-[0-9]*-//" | sed -e "s/\.flac//" `;\
		metaflac --set-tag="TITLE=$$title" ${DIR}/"$$file"; \
	done

set-track:
	for i in `seq -w ${TRACK}`; do metaflac --set-tag="TRACKNUMBER=$$i" ${DIR}/*$$i-*; done
