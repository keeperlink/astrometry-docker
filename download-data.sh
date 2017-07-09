#!/bin/bash
level=${1:-8}
echo level: $level
dstdir=/usr/local/astrometry/data
afiles=()
for (( c=19; c>=0 && c>=level; c-- ))
do
  printf -v cc "%02d" $c
  if [ "$c" -ge "8" ]; then
    afiles+=($cc)
  else
    n=11
    if [ "$c" -le "4" ]; then n=47; fi
    for (( t=0; t<=n; t++ ))
    do
      printf -v tt "%02d" $t
      afiles+=($cc-$tt)
    done
  fi
done

ls -l $dstdir
for i in "${afiles[@]}"
do
  name=index-42$i.fits
  src="http://broiler.astrometry.net/~dstn/4200/$name"
  dst="$dstdir/$name"
  if [ ! -f "$dst" ]; then
    echo wget -o $dst $src
    wget -o $dst $src
  fi
done
ls -l $dstdir
