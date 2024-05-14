EAPI=6

inherit eutils

SRC_URI="https://github.com/cliffordwolf/yosys/archive/${P}.tar.gz"
S="${WORKDIR}/${PN}-${P}"
KEYWORDS="~ppc ~arm64"

LICENSE="ISC"
SLOT="0"
IUSE="tcl +abc plugins readline clang"

RDEPEND="tcl? ( dev-lang/tcl )
	 plugins? ( virtual/libffi virtual/pkgconfig )
	 readline? ( sys-libs/readline )"
DEPEND="abc? ( dev-vcs/mercurial )
	clang? ( sys-devel/clang )
	sys-devel/flex sys-devel/bison dev-build/make
	$RDEPEND"

RESTRICT="abc? ( network-sandbox )"

src_unpack() {
	default_src_unpack
	if use abc; then
		cd ${S} || die
		local ABCURL=$(sed -ne '/^ABCURL/s/^.*=//p;T;q' < Makefile)
		local ABCREV=$(sed -ne '/^ABCREV/s/^.*=//p;T;q' < Makefile)
		hg clone ${ABCURL:-https://bitbucket.org/alanmi/abc} abc || die
		cd abc && hg update -r ${ABCREV} || die
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
	) > Makefile.conf
}

src_compile() {
	emake PREFIX="/usr" || die "emake failed"
}

src_install() {
	emake PREFIX="/usr" DESTDIR="${D}" install
}
