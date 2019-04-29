EAPI=5

inherit eutils

if [[ ${PV} = *9999* ]]; then
	EGIT_REPO_URI="git://github.com/cliffordwolf/yosys.git"
	inherit git-2
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="https://github.com/cliffordwolf/yosys/archive/${P}.tar.gz"
	S="${WORKDIR}/${PN}-${P}"
	KEYWORDS="~ppc ~arm64"
fi

LICENSE="ISC"
SLOT="0"
IUSE="tcl +abc plugins readline clang"

RDEPEND="tcl? ( dev-lang/tcl )
	 plugins? ( virtual/libffi virtual/pkgconfig )
	 readline? ( sys-libs/readline )"
DEPEND="abc? ( dev-vcs/git )
	clang? ( sys-devel/clang )
	sys-devel/flex sys-devel/bison sys-devel/make
	$RDEPEND"

src_unpack() {
	if [[ ${PV} = *9999* ]]; then
		git-2_src_unpack
	else
		default_src_unpack
	fi
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
