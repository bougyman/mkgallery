#!/bin/sh -e
index() {
  cat << DOC
<!doctype html>
<html class="no-js" lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>${title}</title>
    <link rel="stylesheet" href="/css/foundation.css" />
    <script src="/js/vendor/modernizr.js"></script>
  </head>
  <body>
    
    <div class="row">
      <div class="large-12 columns">
        <div class="panel">
          <h3>${description}</h3>
        </div>
      </div>
    </div>

    <div class="row">
      <div class="large-12 medium-12 columns">
        <!-- Picture Grid -->
        <div data-interchange="[ul.html, (default)], [ul-m.html, (medium)], [ul-lg.html, (large)]" class="clearing-images">
          <a href="ul">Images (no javascript)</a>
        </div>
      </div>
      <hr />
      <div class="large-4-centered">
        <section>
          <address>
            Copyright 2014 (c) Tj Vanderpoel
          </address>
        </section>
      </div>
    </div>     
    
    <script src="/js/vendor/jquery.js"></script>
    <script src="/js/foundation.min.js"></script>
    <script src="/js/lightbox.min.js"></script>
    <script>
      \$(document).foundation();
    </script>
  </body>
</html>
DOC
}

get_files() {
  ls *.jpg *.png *.gif 2>/dev/null
}

li_line() {
  img_path=$1
  img=${img_path##*/}
  echo "<li><a href=\"$img_path\" class="th"><img src=\"$thumb_path/$img\" data-caption=\"$img\"></img></a></li>"
}

row_header() {
  echo '<div class="row">'
}

close_div() {
  echo '</div>'
}

image_group() {
  shift
  for img in "$@"; do
    echo "<div class=\"large-${colsize} medium-${colsize} small-${colsize} columns\">"
    image_line "$web_path"/"$img"
    close_div
  done
}

gallery() {
  columns=$1
  echo "<ul class=\"clearing-thumbs large-12 medium-12 small-12 small-block-grid-${columns}\" data-clearing>"
  get_files|while read img; do
    li_line "$web_path"/"$img"
  done
  echo "</ul>"
  cat << HTML
  <script>
  \$(document).foundation('clearing', 'reflow');
  </script>
HTML
}

gallery_path=$(pwd)
gallery_base=${gallery_path##*/}

usage() {
  echo "Create a gallery from images in current directory"
  echo "$0 [OPTIONS] <number of columns>"
  echo "  OPTIONS"
  echo "  -n NAME - gallery name DEFAULT: ${gallery_base}"
  echo "  -w PATH - web path to this gallery DEFAULT: /${gallery_base}"
  echo "  -t PATH - thumbnail path to this gallery DEFAULT: /${gallery_base}/thumbs"
  echo "  -c COLS - number of columns DEFAULT: 3"
  echo "  -i      - build index instead of images.html"
  echo "  -d DESC - gallery description"
  echo "  -T DESC - gallery title"
}
build_index=""
ul=""
while getopts ":n:c:w:d:T:mhi" opt;do
  case $opt in
    u) ul=true
      ;;
    i) build_index=true
      ;;
    n) gallery_name=$OPTARG
      ;;
    t) thumb_path=$OPTARG
      ;;
    w) web_path=$OPTARG
      ;;
    c) num_cols=$OPTARG
      ;;
    d) description=$OPTARG
      ;;
    T) title=$OPTARG
      ;;
    m) make_thumbs=true
      ;;
    h) usage
       exit
       ;;
    \?) echo "Invalid option" 1>&2
        exit 13
        ;;
  esac
done
shift $((OPTIND-1))
declare -a group
gallery_name=${gallery_name:-${gallery_base}}
web_path=${web_path:-/${gallery_base}}
thumb_path=${thumb_path:-${web_path}/thumbs}
echo "Name: $gallery_name Web path: $web_path Thumbs: $thumb_path Columns: ${num_cols:-3}" 1>&2
if [ -n "$make_thumbs" ];then
  echo "Making thumbs in $tmumb_path" 1>&2
  ls *.jpg *.png *.gif 2>/dev/null|while read m;do
    #if [ ! -f "$m" ];then
      #continue
    #fi
    file=${m##*/}
    if [ -f "thumbs/$file" ];then
      echo "thumbs/${file} already exists, skipping" 1>&2
    else
      gm convert -resize 240x160 "$m" thumbs/"$file"
    fi
  done
  echo "Thumbs created in thumbs/" 1>&2
  exit
fi
if [ -n "$build_index" ];then
  echo "Building Index" 1>&2
  description=${description:-${gallery_name}}
  title=${title:-${gallery_name}}
  index
else
  echo "Building Gallery" 1>&2
  gallery ${num_cols:-3}
fi

