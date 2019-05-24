#!/bin/bash
set -e

#build silk dependency
mkdir -p /opt/silk
git clone --depth 1 https://github.com/gaozehua/SILKCodec.git /opt/silk/SILKCodec
cd /opt/silk/SILKCodec/SILK_SDK_SRC_FIX
CFLAGS='-fPIC' make all

cd /opt

mkdir -p /opt/opus
git clone  https://github.com/xiph/opus.git /opt/opus
cd /opt/opus
git checkout v1.2.1
./autogen.sh
./configure --enable-shared --with-pic --enable-static
# ./configure --disable-shared --with-pic --enable-static
make
make install

# ln -s /usr/local/lib/libopus.a /usr/local/lib/libopusstatic.a
ln -s /usr/local/lib/libopus.so /usr/local/lib/libopusstatic.so

##some hack fix
ln -s /usr/include/opus /opt/opus/include/opus

#make orkbase
cd /oreka-src/orkbasecxx
autoreconf -i
./configure CXX=g++
make
make install


#g729
mkdir -p /opt/bcg729
git clone --depth 1 https://github.com/BelledonneCommunications/bcg729.git /opt/bcg729
cd /opt/bcg729
sh ./autogen.sh 
CFLAGS=-fPIC ./configure --prefix /usr
make
make install

#orkaudio

cd /oreka-src/orkaudio
autoreconf -i
./configure CXX=g++
make
make install

#ldd
echo "/usr/lib" > /etc/ld.so.conf.d/usr_lib.conf
ldconfig