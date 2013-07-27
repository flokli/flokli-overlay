# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit versionator

# needed to download the archive
MAJ_PV="$(get_major_version)"
MED_PV="$(get_version_component_range 2)"
MIN_PV="$(get_version_component_range 3)"

# build time dependency
# fork of the google project with riak specific changes
# is used to build the eleveldb lib and gets removed before install
LEVELDB_PV="1.3.0"
LEVELDB_URI="https://github.com/basho/leveldb/archive/${LEVELDB_PV}.tar.gz"
LEVELDB_P="leveldb-${LEVELDB_PV}.tar.gz"
LEVELDB_WD="${WORKDIR}/leveldb-${LEVELDB_PV}"
LEVELDB_TARGET_LOCATION="${S}/deps/eleveldb/c_src/leveldb"

DESCRIPTION="An open source, distributed database"
HOMEPAGE="http://www.basho.com/"
SRC_URI="http://s3.amazonaws.com/downloads.basho.com/${PN}/${MAJ_PV}.${MED_PV}/${PV}/${P}.tar.gz
${LEVELDB_URI} -> ${LEVELDB_P}
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

# TODO test non smp install
RDEPEND="
<dev-lang/erlang-16
>=dev-lang/erlang-15.2.3.1[smp]
"

DEPEND="${RDEPEND}"

pkg_setup() {
	ebegin "Creating riak user and group"
	local riak_home="/var/lib/riak"
	enewgroup riak
	enewuser riak -1 -1 $riak_home riak
	eend $?
}

src_prepare() {
	epatch "${FILESDIR}/${PV}-fix-directories.patch"
	sed -i -e '/XLDFLAGS="$(LDFLAGS)"/d' -e 's/ $(CFLAGS)//g' deps/erlang_js/c_src/Makefile || die

	# avoid fetching deps via git that are already available
	ln -s ${LEVELDB_WD} ${LEVELDB_TARGET_LOCATION}
	mkdir -p "${S}"/deps/riaknostic/deps
	ln -s "${S}"/deps/lager "${S}"/deps/riaknostic/deps
	ln -s "${S}"/deps/meck "${S}"/deps/riaknostic/deps
	ln -s "${S}"/deps/getopt "${S}"/deps/riaknostic/deps
}

src_compile() {
	# build fails with MAKEOPTS > -j1
	emake -j1 rel
}

src_install() {
	# install /usr/lib
	insinto /usr/lib/riak
	cp -R rel/riak/lib "${D}"/usr/lib/riak
	cp -R rel/riak/releases "${D}"/usr/lib/riak
	cp -R rel/riak/erts* "${D}"/usr/lib/riak
	chmod 0755 "${D}"/usr/lib/riak/erts*/bin/*

	# install /usr/bin
	dobin rel/riak/bin/*

	# install /etc/riak
	insinto /etc/riak
	doins rel/riak/etc/*

	# restrict access to cert and key
	fperms 0600 /etc/riak/cert.pem
	fperms 0600 /etc/riak/key.pem

	# create neccessary directories
	keepdir /var/lib/riak/{bitcask,ring}
	keepdir /var/log/riak/sasl
	keepdir /run/riak

	# change owner to riak
	fowners -R riak:riak /var/lib/riak
	fowners -R riak:riak /var/log/riak
	fowners riak:riak /run/riak

	# create docs
	doman doc/man/man1/*
	use doc && dodoc doc/*.txt

	# init.d file
	newinitd "${FILESDIR}/${P}.initd" riak
	newconfd "${FILESDIR}/${P}.confd" riak

	# TODO logrotate
}

pkg_postinst() {
	ewarn "To use kernel polling build erlang with the 'kpoll' useflag"
}
