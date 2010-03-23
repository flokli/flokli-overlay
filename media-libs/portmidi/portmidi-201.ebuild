# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils subversion

DESCRIPTION="Portable API for real-time MIDI I/O"
HOMEPAGE="http://portmedia.sourceforge.net/"
SRC_URI=""

ESVN_REPO_URI="https://portmedia.svn.sourceforge.net/svnroot/portmedia/portmidi/trunk"
#ESVN_PROJECT="portmidi"
ESVN_OPTIONS="-r $PV"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="media-libs/alsa-lib
	virtual/jdk"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}

src_configure() {
	epatch "${FILESDIR}/${P}.diff"
	local CMAKE_VARIABLES=""
	CMAKE_VARIABLES="${CMAKE_VARIABLES} -DCMAKE_INSTALL_PREFIX=/usr"
	#CMAKE_VARIABLES="${CMAKE_VARIABLES} -DJAVA_INCLUDE_PATH:PATH=`java-config -O`/include"
	cmake ${CMAKE_VARIABLES} .
	touch pm_java/INSTALL
}

src_compile() {
	emake -j1 || die "make failed"
}

src_install() {
	mv pm_java/Release pm_java/pmdefaults.jar
	mkdir pm_java/Release
	mv pm_java/pmdefaults.jar pm_java/Release/
	cp -R pm_java/pmdefaults/* pm_java/Release/
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc license.txt README.txt pm_linux/README_LINUX.txt || die "docs install failed"
}
