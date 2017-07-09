#!/bin/bash
level=${1:-8}
echo level: $level
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
echo afiles=$afiles

for i in "${afiles[@]}"
do
  name=index-42$i.fits
  src="http://broiler.astrometry.net/~dstn/4200/$name"
  dst="/usr/local/astrometry/data/$name"
  if [ ! -f "$dst" ]; then
    wget -o $dst $src
  fi
done
