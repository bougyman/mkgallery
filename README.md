## Requirements

* <a href="http://foundation.zurb.com/">Foundation 5</a> must be available in web root as /js, /css, and /img.
* <a href="http://www.graphicsmagick.org/">GraphicsMagick</a> is used for thumbnail creation

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
 
## Example

* Automatic
```
cd <directory_with_images>
img_gallery.sh
```
* Manual
```
cd <directory_with_images>
gallery.sh -i > gallery.html
gallery.sh -c2 > ul.html
gallery.sh -c4 > ul-m.html
gallery.sh -c6 > ul-lg.html
mkdir thumbs
gallery.sh -m
```
The gallery should be viewable at http://webserver/\<directory\_with\_images\>

This assumes \<directory\_with\_images\> is served a the / of webroot. Use the -w option to prefix paths from webroot to the current directory.

## Demo

Sample output at http://dev.bougyman.com/monument
