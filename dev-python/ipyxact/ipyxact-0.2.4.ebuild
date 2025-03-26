EAPI=7

PYTHON_COMPAT=( python3_{5,6,7,8,9,10,11,12} )

inherit distutils-r1 pypi

DESCRIPTION="Python-based IP-XACT parser"
HOMEPAGE="https://github.com/olofk/ipyxact"
SRC_URI="$(pypi_sdist_url ${PN^} ${PV})"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~arm64 ~ppc ~ppc64"

RDEPEND="${PYTHON_DEPS}
	dev-python/pyyaml[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}
        dev-python/setuptools[${PYTHON_USEDEP}]
"
