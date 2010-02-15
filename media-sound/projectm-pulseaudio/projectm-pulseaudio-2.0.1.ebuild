# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit cmake-utils

MY_P=${P/m/M}-Source

DESCRIPTION="A Qt based GUI for projectM that visualizes your Pulseaudio output."
HOMEPAGE="http://projectm.sourceforge.net"
SRC_URI="mirror://sourceforge/projectm/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="media-sound/pulseaudio
	>=media-libs/libprojectm-qt-2.0.1"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${MY_P}

src_compile() {
	cmake-utils_src_configure
	#during build, cmake generates a ${MY_P}_build/ui_PulseDeviceChooserDialog.h,
	#but later searches for it in ${MY_P} -> creating symlink
	ln -sfn ../${MY_P}_build/ui_PulseDeviceChooserDialog.h ui_PulseDeviceChooserDialog.h
	cmake-utils_src_make
}
