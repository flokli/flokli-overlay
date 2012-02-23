# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit eutils

MY_PN="Sublime%20Text%202%20Build"
MY_P="${MY_PN}%20${PV}"

DESCRIPTION="Sublime Text is a sophisticated text editor for code, html and prose"
HOMEPAGE="http://www.sublimetext.com"
COMMON_URI="http://c758482.r82.cf2.rackcdn.com"
SRC_URI="amd64? ( ${COMMON_URI}/${MY_P}%20x64.tar.bz2 )
  x86? ( ${COMMON_URI}/${MY_P}.tar.bz2 )"
LICENSE="Sublime"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="media-libs/libpng
 >=x11-libs/gtk+-2.24.8-r1:2"
DEPEND="${RDEPEND}"

src_install() {
  insinto /opt/${PN}
  into /opt/${PN}
  exeinto /opt/${PN}
  doins -r "Sublime Text 2/lib"
  doins -r "Sublime Text 2/Pristine Packages"
  doins "Sublime Text 2/sublime_plugin.py"
  doins "Sublime Text 2/PackageSetup.py"
  doexe "Sublime Text 2/sublime_text"
  dosym "/opt/${PN}/sublime_text" /usr/bin/subl
  make_desktop_entry "subl %U" "Sublime Text Editor" "accessories-text-editor" "Application;TextEditor" "MimeType=text/plain;"
}
