EAPI=8

if [[ ${PV} = *9999* ]]; then
	EGIT_REPO_URI="https://github.com/YosysHQ/yosys.git"
	inherit git-r3
	SRC_URI=""
	KEYWORDS=""
else
	if ver_test -ge 0.48; then
	  MY_P=v${PV}
	elif ver_test -ge 0.45; then
	  MY_P=${PV}
	else
	  MY_P=${P}
	fi
	if ver_test -ge 0.51; then
	  SRC_URI="https://github.com/YosysHQ/yosys/releases/download/${MY_P}/yosys.tar.gz -> yosys-${PV}.tar.gz"
	  S="${WORKDIR}"
	else
	  SRC_URI="https://github.com/YosysHQ/yosys/archive/refs/tags/${MY_P}.tar.gz
	           abc? ( https://github.com/YosysHQ/yosys/releases/download/${MY_P}/abc.tar.gz -> ${PN}-abc-${PV}.tar.gz )"
	  S="${WORKDIR}/${PN}-${P}"
	fi
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
		use abc && git -C ${S} submodule init
	else
		default_src_unpack
		if ver_test -lt 0.51; then
		  use abc && test -d ${S}/abc && rmdir ${S}/abc
		  use abc && mv ${WORKDIR}/*abc-* ${S}/abc
		fi
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
