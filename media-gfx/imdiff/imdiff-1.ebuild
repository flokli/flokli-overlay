# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils

DESCRIPTION="compare / diff between two images"
HOMEPAGE="http://en.positon.org/post/Compare-/-diff-between-two-images"
SRC_URI="http://en.positon.org/public/imdiff"

LICENSE=""
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="media-gfx/imagemagick"
RDEPEND="${DEPEND}"

src_unpack() {
	mkdir "${S}"
	mv ${DISTDIR}/${PN} ${S}
}

src_prepare() {
	cd ${S}
	epatch "${FILESDIR}/${PN}.patch"
}

src_install() {
	dobin ${PN}
}

