# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/syslog-summary/syslog-summary-1.14.ebuild,v 1.2 2010/03/12 10:21:03 phajdan.jr Exp $

EAPI=2
PYTHON_DEPEND="2:2.5"

inherit git

DESCRIPTION="Summarizes the contents of a syslog log file."
HOMEPAGE="http://github.com/globalcitizen/lxc-gentoo"
EGIT_REPO_URI="git://github.com/globalcitizen/lxc-gentoo.git"
#SRC_URI="http://github.com/globalcitizen/lxc-gentoo"o/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND=""

src_install() {
dobin lxc-gentoo
}