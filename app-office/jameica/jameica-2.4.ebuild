# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils

DESCRIPTION="Jameica Online Banking Software, written in Java"
HOMEPAGE="http://www.willuhn.de/products/jameica/"
SRC_URI="x86? ( http://www.willuhn.de/products/${PN}/releases/${PV}/${PN}/${PN}-linux.zip
			-> ${P}.zip )
		 amd64? (
		 http://www.willuhn.de/products/${PN}/releases/${PV}/${PN}/${PN}-linux64.zip
		 	-> ${P}-amd64.zip )"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND="${DEPEND}
>=virtual/jre-1.6.0"

src_unpack() {
	S="$WORKDIR"

	mkdir -p "usr/share"

	if use x86;then
		unzip ${DISTDIR}/${P}.zip -d usr/share/
	elif use amd64; then
		unzip ${DISTDIR}/${P}-amd64.zip -d usr/share/
	fi

	mkdir -p "usr/bin"
	echo "/usr/share/${PN}/${PN}.sh" >> usr/bin/${PN}
	chmod a+x usr/bin/${PN}
}

src_install() {
	cp -R "${S}/." "${D}/"
	newicon usr/share/${PN}/${PN}-icon.png ${PN}.png
	make_desktop_entry ${PN}
}

pkg_postinst() {
	elog
	elog "You may want to install app-office/hibiscus"
	elog
}
