# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit eutils

DESCRIPTION="organization management tool for Jameica"
HOMEPAGE="http://www.jverein.de/"
SRC_URI="http://sourceforge.net/projects/jverein/files/V_${PV%.*}/jverein.${PVR}.zip"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=app-office/jameica-${PV%.*}
>=app-office/hibiscus-${PV%.*}"

RDEPEND="${DEPEND}"

src_unpack() {
	S="$WORKDIR"

	mkdir -p "usr/share/jameica/plugins"
	unzip ${DISTDIR}/jverein.${PVR}.zip -d usr/share/jameica/plugins/
}

src_install() {
	cp -R "${S}/." "${D}/"
}

