# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit eutils linux-info linux-mod

DESCRIPTION="GPL Linux MIDI drivers for Hercules DJ midi controller devices"
HOMEPAGE="http://ts.hercules.com/eng/index.php?pg=view_files&gid=2&fid=28&pid=215&cid=1"
MY_P="Hercules_DJSeries_Linux"

SRC_URI="ftp://ftp.hercules.com/pub/webupdate/DJCSeries/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="app-arch/rpm2targz"
RDEPEND="${DEPEND}"


src_unpack() {
  unpack ${MY_P}.tgz || die "unpacking ${MY_P}.tgz failed";
  cd "kernel module"
  ebegin "unpacking hdjmod-dkms-${PV}-1.noarch.rpm"
  rpm2targz hdjmod-dkms-${PV}-1.noarch.rpm || (eend 1;die "unpacking hdjmod-dkms-${PV}-1.noarch.rpm failed";)
  eend 0

  ebegin "unpacking hdjmod-dkms-${PV}-1.noarch.tar.gz"
  tar xzf hdjmod-dkms-${PV}-1.noarch.tar.gz || (eend 1;die "unpacking hdjmod-dkms-${PV}-1.noarch.tar.gz failed";)
  eend 0
}

src_prepare() {
  mv "kernel module/usr/src/hdjmod-${PV}" ${S}
  cd ${S}
  epatch "${FILESDIR}/snd_card_create.patch" || die "snd_card_create.patch failed"
}

src_configure() {
  local CONFIG_CHECK="SND_RAWMIDI SND_VIRMIDI"
  check_extra_config
  BUILD_TARGETS="clean modules"
  MODULE_NAMES="hdj_mod()"
  BUILD_PARAMS="ARCH=x86_64"
}
