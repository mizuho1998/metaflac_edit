ALBUM_DIR=""
FILE=""
IMPORT_TAG_FILE="import_tags.txt"
TRACK=10


chmod:
	find ${ALBUM_DIR} -name "*.flac" -not -name ".*" -print | xargs -l -d '\n' chmod -- 777

check:
	ls "${ALBUM_DIR}" | while read file; do \
		echo "$$file"; \
		metaflac --list --block-type=VORBIS_COMMENT "${ALBUM_DIR}/$$file"; \
		echo "";\
	done

get-metatag:
	metaflac --export-tags-to=export_tags.txt "${FILE}"
	cat export_tags.txt >> "${IMPORT_TAG_FILE}"

set-all-tag: set-common-tag set-title set-track

set-common-tag:
	ls "${ALBUM_DIR}" | while read file; do metaflac --remove-all-tags --import-tags-from="${IMPORT_TAG_FILE}" "${ALBUM_DIR}/$$file"; done

set-title:
	ls "${ALBUM_DIR}" | while read file; \
	do \
		title=`echo "$$file" | sed -e "s/[0-9]\+\(\(-\)\|\( \)\)//" | sed -e "s/[0-9]\+\(\(-\)\|\( \)\)//" | sed -e "s/\.flac//" `;\
		metaflac --set-tag="TITLE=$$title" "${ALBUM_DIR}/$$file"; \
	done

set-track:
	$(eval TRACK=$(shell ls "${ALBUM_DIR}" | grep .flac | wc -l))
	file=``
	for i in `seq -w ${TRACK}`; do metaflac --set-tag="TRACKNUMBER=$$i/${TRACK}" "${ALBUM_DIR}/"*"$$i"["-"," "]*; done
