# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit autotools-utils db-use eutils flag-o-matic pam

DESCRIPTION="Open Source Jabber Server"
HOMEPAGE="http://jabberd2.xiaoka.com/ https://github.com/Jabberd2/jabberd2"
SRC_URI="mirror://github/${PN}/${PN}/jabberd-${PV}.tar.xz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="berkdb debug memdebug mysql ldap loggingmsgtodb pam postgres sqlite ssl static-libs test zlib"

CDEPEND="dev-libs/expat
	net-libs/udns
	net-dns/libidn
	>=virtual/gsasl-0.2.28
	berkdb? ( >=sys-libs/db-4.2 )
	mysql? ( virtual/mysql )
	ldap? ( net-nds/openldap )
	pam? ( virtual/pam )
	postgres? ( dev-db/postgresql-base )
	ssl? ( dev-libs/openssl )
	sqlite? ( dev-db/sqlite:3 )
	zlib? ( sys-libs/zlib )"
DEPEND="${CDEPEND}
	test? ( dev-libs/check )
	sys-apps/sed"
RDEPEND="${CDEPEND}
	dev-libs/libxml2
	>=net-im/jabber-base-0.01
	!net-im/jabberd"

S="${WORKDIR}/jabberd-${PV}"

AUTOTOOLS_IN_SOURCE_BUILD=1
DOCS=( AUTHORS README UPGRADE tools/db-setup{.mysql,.pgsql,.sqlite} tools/pipe-auth.pl )
src_prepare() {

	epatch -p1 "${FILESDIR}/jabberd2-fix-groupinsharedroster.patch"
	if use loggingmsgtodb ; then
		epatch -p1 "${FILESDIR}/jabberd2-add_logging_to_db.patch"
		eautoreconf
	fi
}

src_configure() {
	# https://bugs.gentoo.org/show_bug.cgi?id=207655#c3
	replace-flags -O[3s] -O2

	use berkdb && myconf="${myconf} --with-extra-include-path=$(db_includedir)"

	if use debug; then
		myconf="${myconf} --enable-debug"
		# --enable-pool-debug is currently broken
		use memdebug && myconf="${myconf} --enable-nad-debug"
	else
		if use memdebug; then
			ewarn
			ewarn '"memdebug" requires "debug" enabled.'
			ewarn
		fi
	fi
	sed -i \
		-e 's/^initdir = .*/initdir =/' \
		-e 's/^init_DATA = .*/init_DATA =/' etc/Makefile.in

	local myeconfargs=( \
		--sysconfdir=/etc/jabber \
		--enable-fs --enable-pipe --enable-anon \
		${myconf} \
		$(use_enable berkdb db) \
		$(use_enable ldap) \
		$(use_enable mysql) \
		$(use_enable pam) \
		$(use_enable postgres pgsql) \
		$(use_enable sqlite) \
		$(use_enable ssl) \
		$(use_enable test tests) \
		$(use_with zlib)
		)
	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install

	fowners root:jabber /usr/bin/{jabberd,router,sm,c2s,s2s}
	fperms 750 /usr/bin/{jabberd,router,sm,c2s,s2s}

	newinitd "${FILESDIR}/${PN}.init" jabberd
	newpamd "${FILESDIR}/${PN}.pamd" jabberd
	insinto /etc/logrotate.d
	newins "${FILESDIR}/jabberd2-logrotate.conf" "jabberd"

	pushd "${D}/etc/jabber/"
	sed -i \
		-e 's,/var/lib/jabberd/pid/,/var/run/jabber/,g' \
		-e 's,/var/lib/jabberd/log/,/var/log/jabber/,g' \
		-e 's,/var/lib/jabberd/db,/var/spool/jabber/,g' \
		*.xml *.xml.dist || die "sed failed"
	sed -i \
		-e 's,<module>mysql</module>,<module>db</module>,' \
		c2s.xml* || die "sed failed"
	sed -i \
		-e 's,<driver>mysql</driver>,<driver>db</driver>,' \
		sm.xml* || die "sed failed"
	popd
}

pkg_postinst() {
	if use pam; then
		echo
		ewarn 'Jabberd-2 PAM authentication requires your unix usernames to'
		ewarn 'be in the form of "contactname@jabberdomain". This behavior'
		ewarn 'is likely to change in future versions of jabberd-2. It may'
		ewarn 'be advisable to avoid PAM authentication for the time being.'
		echo
	fi
}
