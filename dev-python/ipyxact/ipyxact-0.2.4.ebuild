EAPI=7

PYTHON_COMPAT=( python3_{5,6,7,8,9,10,11} )

inherit distutils-r1 eutils

DESCRIPTION="Python-based IP-XACT parser"
HOMEPAGE="https://github.com/olofk/ipyxact"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~arm64 ~ppc ~ppc64"

RDEPEND="${PYTHON_DEPS}
	dev-python/pyyaml[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}
        dev-python/setuptools[${PYTHON_USEDEP}]
"
