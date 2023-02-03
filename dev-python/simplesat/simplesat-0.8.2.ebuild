EAPI=7

PYTHON_COMPAT=( python3_{5,6,7,8,9,10} )

inherit distutils-r1 eutils

DESCRIPTION="SAT solver for use in Enstaller, based on the MiniSat implementation"
HOMEPAGE="https://github.com/enthought/sat-solver"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~arm64 ~ppc ~ppc64"

RDEPEND="${PYTHON_DEPS}
	>=dev-python/attrs-17.4.0[${PYTHON_USEDEP}]
	>=dev-python/okonomiyaki-0.16.6[${PYTHON_USEDEP}]
	>=dev-python/six-1.10.0[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}
        dev-python/setuptools[${PYTHON_USEDEP}]
"
