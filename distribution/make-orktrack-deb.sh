#!/bin/bash
set -ex

BUILD_ROOT=$(mktemp -d)
VERSION=$(date +%s)
cp -r deb/orktrack/* $BUILD_ROOT/

mkdir -p $BUILD_ROOT/var/lib/tomcat8/webapps/

cp orktrack-0.0.2-SNAPSHOT.war $BUILD_ROOT/var/lib/tomcat8/webapps/orktrack.war


find $BUILD_ROOT -name '.ignore' -delete

sed -i "s/_VERSION_/$VERSION/g" $BUILD_ROOT/DEBIAN/control
dpkg-deb --build $BUILD_ROOT orktrack.deb

rm -rf $BUILD_ROOT