%global ver 6.0.0

Summary: llvm + clang
Name: llvm-clang
Version: %{ver}
Release: 1%{?dist}
License: Proprietary
Vendor: www.billing.ru
Packager: www.billing.ru
Group: lang
URL: http://www.billing.ru

# disable removing debug info
%global __os_install_post /usr/lib/rpm/brp-compress %{nil}
%global _builddir $(pwd)

%description
llvm + clang

%build
mkdir -p build
cd build
cmake3 .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=$RPM_BUILD_ROOT/usr/local/%{name}-%{ver}
make -j 4

%install
mkdir -p $RPM_BUILD_ROOT/usr/local/%{name}-%{ver}
cd build
make install

%clean
rm -rf $RPM_BUILD_ROOT

%files
/usr/local/%{name}-%{ver}

%changelog
* Mon May  7 2018 www.billing.ru
  - initial version
