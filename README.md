metaflac\_edit
===

It is for setting the meta tags of flac files.

*requires:*
- `metaflac` command
	If you don't have the command, you can install it by `sudo apt install flac/bionic`.



# Usage

directory storucture:

```
MUSICS
├── ARTIST_1
│   ├── ALBUM_1
│   ├── ALBUM_2
│   ├── ALBUM_3
│   ...
├── ARTIST_2
│   ├── ALBUM_1
│   ├── ALBUM_2
│   ├── ALBUM_3
│   ...
...

```

fimename: `00-00-music_name.flac` or `00 00 music_name.flac`


### Set meta tag

1. You have to set `ALBUM_DIR` and `IMPORT_TAG_FILE` value in Makefile.

1. Write the set meta tag to a file(`IMPORT_TAG_FILE`). An example can be found in `import_tags.txt`. Also, by executing `make get_metatag`, you can write the meta tag of any flac file to `export_tags.txt`.

1. Then, exec `make set-all-tag`. You can set meta tags to all flac file in the album.


### Set meta tag for  many album

1. `get_albums_tags.sh -d {ARTIST_DIR}`
1. Edit the exported meta file in the ARTIST\_DIR.
1. `set_albums_tags.sh -d {ARTIST_DIR}`
