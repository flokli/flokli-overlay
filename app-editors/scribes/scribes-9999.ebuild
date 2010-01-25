# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
NEED_PYTHON=2.5

inherit gnome2 multilib python bzr

EBZR_REPO_URI="http://bazaar.launchpad.net/~mystilleef/scribes/scribes-dev-0.4"

DESCRIPTION="a text editor that is simple, slim and sleek, yet powerful."
HOMEPAGE="http://scribes.sourceforge.net"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="gnome-base/gconf
	gnome-extra/yelp
	dev-libs/dbus-glib
	dev-python/dbus-python
	dev-python/gnome-python
	dev-python/gnome-python-extras
	dev-python/gnome-python-desktop"
DEPEND="${RDEPEND}
	app-text/gnome-doc-utils
	dev-util/pkgconfig
	dev-util/intltool
	sys-devel/gettext"

DOCS="AUTHORS ChangeLog CONTRIBUTORS NEWS README TODO TRANSLATORS"

pkg_setup() {
	G2CONF="${G2CONF} --disable-scrollkeeper"
}

src_unpack() {
	bzr_src_unpack
	find . -iname *.py[co] -exec rm -f {} \;
	rm -f compile.py py-compile
	touch compile.py py-compile
	fperms +x compile.py py-compile
}

pkg_postinst() {
	gnome2_pkg_postinst
	python_version
	python_mod_optimize /usr/$(get_libdir)/python${PYVER}/site-packages/SCRIBES
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_mod_cleanup
}
