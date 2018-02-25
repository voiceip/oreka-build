#!/bin/bash

#build silk dependency
mkdir -p /opt/silk
git clone --depth 1 https://github.com/gaozehua/SILKCodec.git /opt/silk/SILKCodec
cd /opt/silk/SILKCodec/SILK_SDK_SRC_FIX
CFLAGS='-fPIC' make all


#make orkbase
cd /oreka-src/orkbasecxx
libtoolize --force
automake -a
make -f Makefile.cvs
./configure
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
libtoolize --force
automake -a
make -f Makefile.cvs
./configure LIBS='-ldl'
make
make install

#ldd
echo "/usr/lib" > /etc/ld.so.conf.d/usr_lib.conf
ldconfig