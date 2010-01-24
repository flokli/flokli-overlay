# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Send a HD-audio command"
HOMEPAGE="ftp://ftp.suse.com/pub/people/tiwai/misc/"
SRC_URI="${HOMEPAGE}${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="media-sound/alsa-utils"
RDEPEND=""

src_install() {
	dobin hda-verb
}
