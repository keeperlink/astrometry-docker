FROM ubuntu
MAINTAINER Sergei Goshko <serge@keeperlink.com>
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
  && rm -rf /var/lib/apt/lists/*

ENV PATH="/usr/local/astrometry/bin:${PATH}"
ADD /*.sh /
RUN chmod +x /*.sh

VOLUME ["/usr/local/astrometry/data"]

ENTRYPOINT ["/entry.sh"]
