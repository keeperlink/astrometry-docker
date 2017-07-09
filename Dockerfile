FROM ubuntu
MAINTAINER Sergei Goshko <serge@keeperlink.com>
ADD /download-data.sh /tmp/download-data.sh
RUN set -x \
  && apt-get update \
  && apt-get install -y --no-install-recommends \
     build-essential \
	 ca-certificates \
     file \
     gcc \
	 git \
     libbz2-dev \
     libcairo2-dev \
     libcfitsio-dev \
     libjpeg-dev \
     libnetpbm10 \
     libnetpbm10-dev \
     libpng12-dev \
     libz-dev \
     make \
     nano \
     netpbm \
     pkg-config \
	 pyfits-utils \
     python \
     python-dev \
     python-numpy \
     python-pyfits \
     swig \
     wget \
     zlib1g-dev \
  && rm -rf /var/lib/apt/lists/* \
  && cd /tmp \
  && git clone https://github.com/dstndstn/astrometry.net \
  && cd astrometry.net* \
  && echo "NETPBM_INC=-I/usr/include" > util/makefile.netpbm \
  && echo "NETPBM_LIB=-L/usr/lib -libnetpbm" >> util/makefile.netpbm \
  && make \
  && make py \
  && make extra \
  && make install \
  && cd /tmp \
  && rm -fr /tmp/astrometry.net* \
  && echo "Testing solve-field..." \
  && sleep 5s \
  && chmod +x /tmp/download-data.sh \
  && /tmp/download-data.sh 16 \
  && mkdir /tmp/test \
  && cd /tmp/test \
  && /usr/local/astrometry/bin/solve-field /usr/local/astrometry/examples/apod4.jpg


#  && wget http://astrometry.net/downloads/astrometry.net-latest.tar.gz \
#  && tar -xzf astrometry.net-latest.tar.gz \
#  && rm astrometry.net-latest.tar.gz \

VOLUME ["/usr/local/astrometry/data"]

#ENTRYPOINT ["/download-data.sh", "7"]
