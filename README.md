## Requirements

* <a href="http://foundation.zurb.com/">Foundation 5</a> must be available in web root as /js, /css, and /img.
* GraphicsMagick is used for thumbnail creation

## Usage
```
gallery.sh [OPTIONS]
```
* OPTIONS
  *    -i       Build an .html file as an index
  *    -n NAME  The gallery name
  *    -t PATH  Path to thumbnails relative to web root
  *    -w PATH  Path to this gallery relative to web root
  *    -c COLS  Number of columns of thumbnails
  *    -d DESC  Description for the gallery (Only valid in -i mode)
  *    -T NAME  Title for the gallery (Only valid in -i mode)
  *    -m       Create thumbnails for this gallery
  *    -h       Show Usage
