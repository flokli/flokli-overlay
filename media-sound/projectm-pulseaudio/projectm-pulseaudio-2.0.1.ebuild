# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
inherit cmake-utils

MY_P=${P/m/M}-Source

DESCRIPTION="A Qt based GUI for projectM that visualizes your Pulseaudio output."
HOMEPAGE="http://projectm.sourceforge.net"
SRC_URI="mirror://sourceforge/projectm/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="media-sound/pulseaudio[avahi]
	>=media-libs/libprojectm-qt-2.0.1"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${MY_P}

CMAKE_IN_SOURCE_BUILD=1

src_prepare() {
	cd ${S}
	epatch "${FILESDIR}/include_mkdir.patch"
	epatch "${FILESDIR}/exclude_browserh.patch"
}
