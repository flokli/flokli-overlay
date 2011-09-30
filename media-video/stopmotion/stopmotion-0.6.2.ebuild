# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

EAPI=3

DESCRIPTION="A small v4l frame capture utility especially suited for stop motion animation."
HOMEPAGE="http://developer.skolelinux.no/info/studentgrupper/2005-hig-stopmotion/"
SRC_URI="http://developer.skolelinux.no/info/studentgrupper/2005-hig-stopmotion/project_management/webpage/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="virtual/fam
   sys-fs/inotify-tools
   dev-libs/libxml2 
   dev-libs/libtar 
   media-libs/libvorbis 
   media-libs/libsdl 
   media-libs/sdl-image 
   x11-libs/qt-core"
RDEPEND="${DEPEND}"

src_compile() {
	./configure --prefix=/usr  || die "Configure failed"
	make || die
}

src_install() {
	dobin stopmotion
	into /usr
	dodir /usr/share/doc/${PN}/html
	cp ${WORKDIR}/${P} AUTHORS  README COPYING  ${D}/usr/share/	doc/${PN}
cp -rf         ${WORKDIR}/${P}/html  ${D}/usr/share/doc/${PN}
chmod  755     ${D}/usr/share/doc/${PN}
chmod  644 -R  ${D}/usr/share/doc/${PN} AUTHORS README COPYING   ${D}/usr/share/doc/${PN}/html
}
