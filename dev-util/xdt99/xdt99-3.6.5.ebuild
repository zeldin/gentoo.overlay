EAPI=8

PYTHON_COMPAT=( python3_{11,12,13} )

inherit python-r1

DESCRIPTION="TMS 99xx Cross-Development Tools"
HOMEPAGE="http://endlos99.github.io/xdt99/"
SRC_URI="https://github.com/endlos99/xdt99/releases/download/${PV}/${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~ppc64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	${PYTHON_DEPS}
"
BDEPEND="
	${PYTHON_DEPS}
"

src_prepare() {
	default
	sed -i -e "s/from xcommon import/from xdt99.xcommon import/" *.py
}

python_install() {
	python_moduleinto ${PN}
	python_domodule *.py
	python_fix_shebang "${D}/$(python_get_sitedir)/${PN}"
	for prog in xas99 xbas99 xda99 xdg99 xdm99 xga99 xhm99 xvm99; do
		chmod +x "${ED}/$(python_get_sitedir)/${PN}/${prog}.py"
		dosym "${EPREFIX}/$(python_get_sitedir)/${PN}/${prog}.py" /usr/bin/${prog}.py
	done
	python_optimize
}

src_install() {
	python_foreach_impl python_install
}
