# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit games cmake-utils subversion

DESCRIPTION="Blobby Volley is an arcade game in which you take out a volleyball match"
HOMEPAGE="http://blobby.sourceforge.net/"
ESVN_REPO_URI="https://${PN}.svn.sourceforge.net/svnroot/${PN}/trunk/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-games/physfs
		media-libs/libsdl[opengl]"
RDEPEND="${DEPEND}"

DOCS="AUTHORS ChangeLog NEWS README TODO"

src_install() {
	cmake-utils_src_install
	doicon ${FILESDIR}/blobby.png
	make_desktop_entry ${PN} "Blobby Volley" blobby
	prepgamesdirs
}
