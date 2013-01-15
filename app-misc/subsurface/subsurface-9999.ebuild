# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

if [[ ${PV} = *9999* ]]; then
	EGIT_REPO_URI="git://subsurface.hohndel.org/subsurface.git"
	GIT_ECLASS="git-2"
fi

inherit eutils gnome2-utils ${GIT_ECLASS}

if [[ ${PV} = *9999* ]]; then
	SRC_URI=""
else
	SRC_URI="https://github.com/torvalds/${PN}/tarball/v${PV} -> ${P}.tar.gz"
fi

DESCRIPTION="Subsurface is an open source dive log program"
HOMEPAGE="http://subsurface.hohndel.org"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="usb" # examples"

RDEPEND="dev-libs/glib:2
	dev-libs/libdivecomputer[static-libs,usb?]
	dev-libs/libxml2
	dev-libs/libxslt
	gnome-base/gconf
	x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	if [[ ${PV} = *9999* ]]; then
		git-2_src_unpack
	else
		unpack ${A}
		mv torvalds-${PN}-* ${P} || die "failed to mv the failes to ${P}"
	fi
}

src_compile() {
	emake \
		CC=$(tc-getCC) \
		LIBDIVECOMPUTERCFLAGS=$(pkg-config --cflags libdivecomputer 2> /dev/null) \
		|| die "emake failed"
		#disable dynamic linking as it is not supported upstream at the moment
		#LIBDIVECOMPUTER=$(pkg-config --static libdivecomputer 2> /dev/null) \
}

src_install() {
	emake install DESTDIR="${D}" gtk_update_icon_cache=""
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
