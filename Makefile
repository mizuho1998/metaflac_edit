ALBUM_DIR=""
OUT_DIR="./"
FILE=""
IMPORT_TAG_FILE="import_tags.txt"
TRACK=10


convert-flac:
	$(eval album_name := $(shell echo "${ALBUM_DIR}" | sed -e "s/.*\/\(.*\)/\1/g"))
	echo "\noutput dir: ${album_name}\n"
	mkdir -p "${OUT_DIR}/${album_name}"
	flac --best --output-prefix="${OUT_DIR}/${album_name}/" "${ALBUM_DIR}/"*

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
