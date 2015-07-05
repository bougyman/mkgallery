#!/bin/sh
gallery.sh -i "$@" > index.html
gallery.sh -c2 "$@" > ul.html
gallery.sh -c4 "$@" > ul-m.html
gallery.sh -c6 "$@" > ul-lg.html
[ -d thumbs ] || mkdir thumbs
gallery.sh -m
