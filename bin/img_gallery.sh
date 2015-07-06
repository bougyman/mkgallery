#!/bin/sh
gallery.sh -i "$@" > index.html  # Make index
gallery.sh "$@"     > ul.html    # small layout
gallery.sh -c4 "$@" > ul-m.html  # medium layout
gallery.sh -c6 "$@" > ul-lg.html # large layout
[ -d thumbs ] || mkdir thumbs    # Make thumbnail dir
gallery.sh -m "$@"               # Generate thumbnails
