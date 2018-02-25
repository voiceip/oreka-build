Name: oreka-g729
Version: 1.0                       
Release: 1%{?dist}                 
Summary: G729 Support for Oreka

Group: Miscellaneous               
License: GPLv2
Source:  %{name}.tar.gz

BuildRoot: %{_tmppath}/%{name}-build

# BuildRequires:                   
# Requires:                        

%description
This is a text describing what the Package is meant for

%prep
%setup -n %{name}

%install

rm -rf $RPM_BUILD_ROOT
mkdir -p $RPM_BUILD_ROOT/usr/lib
mkdir -p $RPM_BUILD_ROOT/usr/sbin
mkdir -p $RPM_BUILD_ROOT/usr/lib/orkaudio/plugins

install -m 0755 /oreka-src/orkaudio/orkaudio  $RPM_BUILD_ROOT/usr/sbin/orkaudio
install -m 0755 /usr/lib/libbcg729.so  $RPM_BUILD_ROOT/usr/lib/libbcg729.so
install -m 0755 /usr/lib/liborkbase.so  $RPM_BUILD_ROOT/usr/lib/liborkbase.so
install -m 0755 /oreka-src/orkaudio/plugins/*.so  $RPM_BUILD_ROOT/usr/lib/orkaudio/plugins/

%post
ln -s /usr/lib/liborkbase.so /usr/lib/liborkbase.so.0
ln -s /usr/lib/libbcg729.so /usr/lib/libbcg729.so.0
/sbin/ldconfig

%clean
rm -rf $RPM_BUILD_ROOT
rm -rf %{_tmppath}/%{name}
rm -rf %{_topdir}/BUILD/%{name}

%files

%defattr(-,root,root,-)

# %doc

/usr/sbin/orkaudio
/usr/lib/liborkbase.*
/usr/lib/libbcg729.*
/usr/lib/orkaudio/plugins/*.so

%changelog
* Sat Feb 24 2018 Kinshuk <me@kinshuk.in>
- Initial Release