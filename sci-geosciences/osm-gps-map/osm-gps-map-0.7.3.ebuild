# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit autotools gnome2

DESCRIPTION="osm-gps-map is a gtk+ viewer for OpenStreetMap files."
HOMEPAGE="http://nzjrs.github.com/osm-gps-map/"
SRC_URI="http://www.johnstowers.co.nz/files/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="introspection python"

DEPEND="
	>=dev-libs/glib-2.16.0
	gnome-base/gnome-common
	>=net-libs/libsoup-2.4.0
	>=x11-libs/cairo-1.6.0
	>=x11-libs/gtk+-2.14.0
	introspection? ( dev-libs/gobject-introspection )
"
RDEPEND="${DEPEND}"
PDEPEND="python? ( dev-python/python-osmgpsmap )"

G2CONF="
	$(use_enable introspection)
	--docdir=/usr/share/doc/${PN}
	--disable-dependency-tracking
	--enable-fast-install
	--disable-static
"

src_prepare() {
	epatch "${FILESDIR}/${PN}-fix-docs-location.patch"
#	epatch "${FILESDIR}/${PN}-disable-compiler-warnings.patch"
	eautoreconf

	gnome2_src_prepare
}
