# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="HBCI Plugin for Jameica"
HOMEPAGE="http://www.willuhn.de/products/hibiscus/"
SRC_URI="http://www.willuhn.de/products/${PN}/releases/${PV}/${PN}.zip"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=app-office/jameica-${PV}"
RDEPEND="${DEPEND}"

src_unpack() {
	S="$WORKDIR"

	mkdir -p "usr/share/jameica/plugins"
	unzip ${DISTDIR}/${PN}.zip -d usr/share/jameica/plugins/
}

src_install() {
	cp -R "${S}/." "${D}/"
}

