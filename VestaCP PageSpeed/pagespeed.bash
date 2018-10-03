#!/bin/bash

# -------- START CONFIG --------
# Check current PageSpeed version at https://www.modpagespeed.com/doc/release_notes
NPS_VERSION=1.13.35.2   # e.g. NPS_VERSION=1.13.35.2
NPS_RELEASE=stable      # stable or beta ONLY

# Check current NGINX version at http://nginx.org/en/download.html
NGINX_VERSION=1.15.5   # e.g. NGINX_VERSION=1.15.5
# -------- START CONFIG --------

# -------- START PROCESS --------

# Makes a combined variable
NPS_VERSION=${NPS_VERSION}-${NPS_RELEASE}
# Get Compile parameters from current NGINX
COMP_PARAMS=`2>&1 nginx -V | grep "configure arguments: "`
COMP_PARAMS="${COMP_PARAMS/configure arguments: }"
# Current script directory
DIR=$(dirname "$(readlink -f "$0")") ;cd $DIR #"
apt-get -qq -y install build-essential zlib1g-dev libpcre3 libpcre3-dev unzip libssl-dev
rm -r incubator* *.zip nginx*
wget -q https://github.com/apache/incubator-pagespeed-ngx/archive/v${NPS_VERSION}.zip
unzip -qq v${NPS_VERSION}.zip
nps_dir=$(find . -name "*pagespeed-ngx-${NPS_VERSION}" -type d); cd "$nps_dir"
NPS_RELEASE_NUMBER=${NPS_VERSION/beta}; NPS_RELEASE_NUMBER=${NPS_RELEASE_NUMBER/stable/}
psol_url=https://dl.google.com/dl/page-speed/psol/${NPS_RELEASE_NUMBER}.tar.gz
[ -e ./scripts/format_binary_url.sh ] && psol_url=$(./scripts/format_binary_url.sh PSOL_BINARY_URL)
wget  ${psol_url}
tar -xzf $(basename ${psol_url})  # extracts to psol/
cd $DIR
wget  http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz
tar -vxzf nginx-${NGINX_VERSION}.tar.gz
cd nginx-${NGINX_VERSION}/
eval "./configure $COMP_PARAMS --add-dynamic-module=$DIR/incubator-pagespeed-ngx-$NPS_VERSION"
make
cp $DIR/nginx-${NGINX_VERSION}/objs/ngx_pagespeed.so /etc/nginx/modules/
service nginx restart
