#!/bin/bash
echo "Astrometry default entry point"

if [ ! -d "/usr/local/astrometry/bin" ]; then
  echo "Building astrometry project..."
  /build.sh
fi

echo "Check/download indexes..."
/download-data.sh ${INDEX_LEVEL:-8}

/bin/bash
