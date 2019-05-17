EAPI=6

inherit subversion wxwidgets

ESVN_REPO_URI="https://svn.icomp.de/svn/chaco"

SLOT="0"
KEYWORDS="~ppc64 ~arm64"
IUSE=""

DEPEND=">=dev-embedded/cc65-1.7
        dev-embedded/64tass
	app-arch/zip
	app-arch/unzip"
REPEND=""

WX_GTK_VER=3.0

pkg_setup() {
    setup-wxwidgets
}

src_prepare() {
    default
    # Fix parallel make
    sed -i 's/make/$(MAKE)/' chtransfer/Makefile
    sed -i '$a\
.NOTPARALLEL:\
' chtransfer/EasyTransfer/Makefile
    sed -i '$a\
.NOTPARALLEL:\
' Makefile
}

src_compile() {
    emake clean
    emake zip
}

src_install() {
    unzip -qo -d unzipped chameleon-tools-linux.zip
    find unzipped -type f | while read file; do
	case "$file" in
	    *.txt)
		dodoc "$file"
		;;
	    *.prg)
		insinto /usr/bin
		doins "$file"
		;;
	    *)
		dobin "$file"
		;;
	esac
    done
}
