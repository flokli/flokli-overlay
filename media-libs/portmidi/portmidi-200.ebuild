# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
inherit cmake-utils eutils java-pkg-2 multilib toolchain-funcs

DESCRIPTION="a computer library for real time MIDI input and output"
HOMEPAGE="http://portmedia.sourceforge.net/"
SRC_URI="mirror://sourceforge/portmedia/${PN}-src-${PV}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND="media-libs/alsa-lib
	>=virtual/jdk-1.5"
DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}/${PN}
CMAKE_IN_SOURCE_BUILD="yes"

pkg_setup() {
	java-pkg-2_pkg_setup
}

src_prepare() {
	if use amd64 ; then
		sed -i  -e 's:i386:amd64:' \
			${S}/pm_dylib/CMakeLists.txt \
			${S}/pm_common/CMakeLists.txt || die "sed failed"
	fi

	sed -i	-e 's:client:server:' \
		-e 's:/usr/local/::' \
		-e 's:portmidi_s:portmidi:' \
		${S}/pm_dylib/CMakeLists.txt \
		${S}/pm_common/CMakeLists.txt || die "sed failed"

	sed -i	-e 's:/usr/local/::' \
		-e 's:/usr/::' \
		${S}/pm_java/CMakeLists.txt || die "sed failed"

	# The following fixes a bug in the build scripts
	mkdir -p ${S}/pm_java/${CMAKE_BUILD_TYPE}
}

src_configure() {
	local mycmakeargs=(
		-DJAVA_INCLUDE_PATH:PATH=`java-config -O`/include
		-DJAVA_INCLUDE_PATH2:PATH=`java-config -O`/include/linux
		-DCMAKE_CACHEFILE_DIR=.
	)

	if use debug ; then
		mycmakeargs+=( -DCMAKE_BUILD_TYPE=Debug )
	fi
	
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile -j1
}

src_install() {
	cmake-utils_src_install
	dodoc CHANGELOG.txt pm_linux/README_LINUX.txt README.txt
}
