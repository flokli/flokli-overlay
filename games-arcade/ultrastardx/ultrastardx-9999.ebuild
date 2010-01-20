# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/ultrastar-deluxe/ultrastar-deluxe-1.1.0.ebuild,v 1.1 2008/07/04 08:41:32 frostwork Exp $

inherit eutils games flag-o-matic subversion

ESVN_REPO_URI="https://ultrastardx.svn.sourceforge.net/svnroot/ultrastardx/trunk"

DESCRIPTION="A free and open source karaoke game"
HOMEPAGE="http://ultrastardx.sourceforge.net/"
#SRC_URI="http://switch.dl.sourceforge.net/sourceforge/ultrastardx/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="projectm"

DEPEND="dev-lang/fpc
	media-libs/sdl-image
	media-libs/libsdl
	media-libs/sdl-mixer
	media-libs/sdl-ttf
	projectm? ( media-libs/libprojectm )
	>=media-libs/portaudio-19_pre20071207
	media-video/ffmpeg
	virtual/opengl
	virtual/glu
	dev-lang/lua"

src_unpack() {
	subversion_src_unpack
	cd "${S}/src"
	epatch "${FILESDIR}"/remove_ffmpeg_checks.patch
}

src_compile() {
	egamesconf \
		$(use_with projectm libprojectM) \
		|| die "Configure failed!"
	emake \
	LDFLAGS="" \
	|| die "emake failed"
}


src_install() {
	dogamesbin game/ultrastardx
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r artwork game/fonts game/languages game/plugins game/resources game/sounds game/themes || die
	keepdir "${GAMES_DATADIR}"/${PN}/covers
	keepdir "${GAMES_DATADIR}"/${PN}/songs
	newicon icons/ultrastardx-icon.svg ultrastardx.svg
	make_desktop_entry ${PN} "Ultrastar Deluxe"
	dodoc README*
	prepgamesdirs
}

