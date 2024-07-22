EAPI=7

if [[ ${PV} = *9999* ]]; then
	EGIT_REPO_URI="https://github.com/YosysHQ/yosys.git"
	inherit git-r3
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="https://github.com/YosysHQ/yosys/archive/${P}.tar.gz
		 abc? ( https://github.com/YosysHQ/yosys/releases/download/${P}/abc.tar.gz -> ${PN}-abc-${PV}.tar.gz )"
	S="${WORKDIR}/${PN}-${P}"
	KEYWORDS="~ppc64 ~arm64"
fi

LICENSE="ISC"
SLOT="0"
IUSE="tcl +abc plugins readline clang"

RDEPEND="tcl? ( dev-lang/tcl )
	 plugins? ( virtual/libffi virtual/pkgconfig )
	 readline? ( sys-libs/readline )"
DEPEND="clang? ( sys-devel/clang )
	sys-devel/flex sys-devel/bison dev-build/make
	$RDEPEND"

src_unpack() {
	if [[ ${PV} = *9999* ]]; then
		git-r3_src_unpack
		if use abc; then
			cd ${S} || die
			local ABCURL=$(sed -ne '/^ABCURL/s/^.*=//p;T;q' < Makefile)
			local ABCREV=$(sed -ne '/^ABCREV/s/^.*=//p;T;q' < Makefile)
			git clone ${ABCURL} abc || die
			cd abc || die
			ABCREV=${ABCREV//[[:space:]]}
			git config --local core.abbrev ${#ABCREV} || die
			git checkout ${ABCREV} || die
		fi
	else
		default_src_unpack
		use abc && test -d ${S}/abc && rmdir ${S}/abc
		use abc && mv ${WORKDIR}/*abc-* ${S}/abc
	fi
}

src_configure() {
	(
		echo "CONFIG := `usex clang clang gcc`"
		echo "ENABLE_TCL := `usex tcl 1 0`"
		echo "ENABLE_ABC := `usex abc 1 0`"
		echo "ENABLE_PLUGINS := `usex plugins 1 0`"
		echo "ENABLE_READLINE := `usex readline 1 0`"
		if ! has_version sys-apps/gawk ; then
			echo "PRETTY := 0"
		fi
		if [[ ${PV} != *9999* ]]; then
			echo "ABCREV := default"
		fi
	) > Makefile.conf
}

src_compile() {
	emake PREFIX="/usr" || die "emake failed"
}

src_install() {
	emake PREFIX="/usr" DESTDIR="${D}" install
}
