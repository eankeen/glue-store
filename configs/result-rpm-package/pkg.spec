Name:    pkgName
Version: pkgVer
Release: 1%{?dist}
Summary: pkgSummary
Group:
License: Public Domain
Source0: pkg-pkgVer
# Source0: https://github.com/eankeen/pkgName/download/%{name}/%{name}-${version}.tar.gz
URL:     pkgUrl
# Requires: bash

%description
pkgDesc

%install
mkdir -p %{buildroot}%{_bindir}
install -p -m 755 %{SOURCE0} %{buildroot}%{_bindir}

%files

%changelog
