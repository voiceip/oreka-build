#!/bin/bash
set -ex

BUILD_ROOT=$(mktemp -d)
export VERSION=$(date +%s)
cp -r deb/orkaudio/* $BUILD_ROOT/

mkdir -p $BUILD_ROOT/usr/sbin
mkdir -p $BUILD_ROOT/etc/orkaudio
mkdir -p $BUILD_ROOT/usr/lib/orkaudio/plugins

cp /oreka-src/orkaudio/orkaudio  $BUILD_ROOT/usr/sbin/orkaudio
cp /usr/lib/x86_64-linux-gnu/libbcg729.so  $BUILD_ROOT/usr/local/lib/libbcg729.so
cp /usr/lib/liborkbase.so  $BUILD_ROOT/usr/local/lib/liborkbase.so
cp /usr/local/lib/libstatsd.so  $BUILD_ROOT/usr/local/lib/libstatsd.so
cp /oreka-src/orkaudio/audiocaptureplugins/voip/.libs/{libvoip.so,libvoip.la} $BUILD_ROOT/usr/lib/
cp /oreka-src/orkaudio/audiocaptureplugins/generator/.libs/{libgenerator.so,libgenerator.la} $BUILD_ROOT/usr/lib/

cp /oreka-src/orkaudio/plugins/*.so  $BUILD_ROOT/usr/lib/orkaudio/plugins/

cp /etc/orkaudio/config.xml $BUILD_ROOT/etc/orkaudio
cp /etc/orkaudio/logging.properties $BUILD_ROOT/etc/orkaudio

find $BUILD_ROOT -name '.ignore' -delete

sed -i "s/_VERSION_/$VERSION/g" $BUILD_ROOT/DEBIAN/control
dpkg-deb --build $BUILD_ROOT orkaudio.deb

rm -rf $BUILD_ROOT