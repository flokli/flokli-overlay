# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

if [[ ${PV} = *9999* ]]; then
	EGIT_REPO_URI="git://libdivecomputer.git.sourceforge.net/gitroot/libdivecomputer/libdivecomputer"
	GIT_ECLASS="git-2"
	AUTOTOOLIZE=yes
fi

inherit eutils autotools-utils ${GIT_ECLASS}

if [[ ${PV} = *9999* ]]; then
	SRC_URI=""
else
	SRC_URI=""
fi

DESCRIPTION="Library for communication with dive computers from various manufacturers"
HOMEPAGE="http://www.divesoftware.org/libdc"
LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="usb examples static-libs"

RDEPEND="usb? ( virtual/libusb:1 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

AUTOTOOLS_IN_SOURCE_BUILD=1

src_prepare() {
	if [[ -n ${AUTOTOOLIZE} ]]; then
		epatch "${FILESDIR}/automake_1.12_fix.patch"
		eautoreconf
	fi
}

src_configure() {
	autotools-utils_src_configure

	use usb || sed -i 's|#define HAVE_LIBUSB 1||' config.h || die "sed failed"
	use examples || sed -i 's|examples||' Makefile || die "sed failed"
}

src_compile() {
        autotools-utils_src_compile
}

src_install() {
	autotools-utils_src_install
}
