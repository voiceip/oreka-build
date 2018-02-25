#!/bin/bash
set -x

if [ -z "$1" ];then
   echo "You didn't specify anything to build";
   exit 1;
fi

pushd ./SOURCES
# # delete older versions of the rpm since there's no point having old 
# # versions in there when we still have the src.rpms in the SRPMS dir
# find /usr/src/packages/RPMS -name ${1}-[0-9]\* -exec rm -f {} \;


# if there's a directory containing the source, as there will be
# for all our own packages, then delete any .tar.gz file that may exist
# for the package and create a new one.
if [ -d ${1} ] ;then
   rm -f ~/rpmbuild/SOURCES/${1}.tar.gz;
   tar zcf${h_or_not} ~/rpmbuild/SOURCES/${1}.tar.gz ${1};
fi

# build the package

popd 

rpmbuild -v -ba --clean ./SPECS/${1}.spec 

# if there is a directory, then delete the .tar.gz again
# if [ -d ${1} ] ;then
#    rm -f ${1}.tar.gz;
# fi