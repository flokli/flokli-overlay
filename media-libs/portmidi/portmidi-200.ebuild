# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
inherit cmake-utils eutils multilib toolchain-funcs

DESCRIPTION="a library for real time MIDI input and output"
HOMEPAGE="http://portmedia.sourceforge.net/"
SRC_URI="mirror://sourceforge/portmedia/${PN}-src-${PV}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND="media-libs/alsa-lib"
DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}/${PN}

CMAKE_IN_SOURCE_BUILD="yes"
CMAKE_USE_RELATIVE_PATHS="yes"
CMAKE_BUILD_TYPE=Release
CMAKE_LIBRARY_OUTPUT_DIRECTORY="/usr/$(get_libdir)"
pkg_setup() {
	if use debug ; then
		CMAKE_BUILD_TYPE=Debug
	fi
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-Makefile.patch

#	sed -i	-e "s:/usr/local/lib:/usr/$(get_libdir):g" \
#		pm_common/CMakeLists.txt pm_dylib/CMakeLists.txt || die "sed failed"
#
#	sed -i	-e "s:/usr/local/include:/usr/include:g" \
#		pm_common/CMakeLists.txt pm_dylib/CMakeLists.txt || die "sed failed"
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_CACHEFILE_DIR=.
	)

	cmake-utils_src_configure
}

src_install() {
	#cmake-utils_src_install
	
	dolib pm_dylib/Release/libportmidi.so
	dolib.a pm_common/Release/libportmidi.a

	insinto /usr/include
	doins pm_common/portmidi.h
	doins porttime/porttime.h
	
	dodoc CHANGELOG.txt pm_linux/README_LINUX.txt README.txt

	dosym libportmidi.so /usr/$(get_libdir)/libporttime.so
	dosym libportmidi.a /usr/$(get_libdir)/libporttime.a
}
