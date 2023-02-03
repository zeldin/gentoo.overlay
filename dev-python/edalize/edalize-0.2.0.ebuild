EAPI=7

PYTHON_COMPAT=( python3_{5,6,7,8,9,10} )

inherit distutils-r1 eutils

DESCRIPTION="An abstraction library for interfacing EDA tools"
HOMEPAGE="https://github.com/olofk/edalize"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~arm64 ~ppc ~ppc64"

RDEPEND="${PYTHON_DEPS}
	>=dev-python/pytest-3.3.0[${PYTHON_USEDEP}]
	>=dev-python/jinja-2.8[${PYTHON_USEDEP}]
	|| ( <dev-python/jinja-2.11[${PYTHON_USEDEP}]
	     >=dev-python/jinja-2.11.2[${PYTHON_USEDEP}] )
"
DEPEND="${RDEPEND}
        dev-python/setuptools[${PYTHON_USEDEP}]
"
