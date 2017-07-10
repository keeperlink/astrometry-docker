#!/bin/bash
cd /tmp
git clone https://github.com/dstndstn/astrometry.net
cd astrometry.net*
echo "NETPBM_INC=-I/usr/include" > util/makefile.netpbm
echo "NETPBM_LIB=-L/usr/lib -libnetpbm" >> util/makefile.netpbm
make
make py
make extra
make install
cd /tmp
rm -fr /tmp/astrometry.net*
echo "Testing solve-field..."
sleep 5s
/download-data.sh 17
mkdir /tmp/test
cd /tmp/test
solve-field /usr/local/astrometry/examples/apod4.jpg
