EAPI=7

PYTHON_COMPAT=( python2_7 python3_{3,4,5,6,7,8,9,10} )

inherit distutils-r1 eutils

DESCRIPTION="Matrices describing affine transformation of the plane."
HOMEPAGE="https://github.com/sgillies/affine"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~arm64 ~ppc ~ppc64"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
        dev-python/setuptools[${PYTHON_USEDEP}]
        test? ( dev-python/pytest[${PYTHON_USEDEP}] )"

python_test() {
        esetup.py test
}
