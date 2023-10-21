EAPI=7

PYTHON_COMPAT=( python3_{5,6,7,8,9,10,11} )

inherit distutils-r1

DESCRIPTION="Self-contained library to deal with metadata in Enthought-specific eggs"
HOMEPAGE="https://github.com/enthought/okonomiyaki"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~arm64 ~ppc ~ppc64"

RDEPEND="${PYTHON_DEPS}
	>=dev-python/attrs-16.1.0[${PYTHON_USEDEP}]
	>=dev-python/jsonschema-2.5.1[${PYTHON_USEDEP}]
	>=dev-python/six-1.9.0[${PYTHON_USEDEP}]
	>=dev-python/zipfile2-0.0.12[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}
        dev-python/setuptools[${PYTHON_USEDEP}]
"
