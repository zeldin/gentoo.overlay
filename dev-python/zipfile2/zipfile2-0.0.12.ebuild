EAPI=6

PYTHON_COMPAT=( python3_{5,6,7,8} )

inherit distutils-r1 eutils

DESCRIPTION="An improved ZipFile class"
HOMEPAGE="https://github.com/cournape/zipfile2"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="PSF-2"
SLOT="0"
KEYWORDS="~arm64 ~ppc ~ppc64"

RDEPEND="${PYTHON_DEPS}
"
DEPEND="${RDEPEND}
        dev-python/setuptools[${PYTHON_USEDEP}]
"
