EAPI=8

PYTHON_COMPAT=( python2_7 python3_{3,4,5,6,7,8,9,10,11,12,13} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi

DESCRIPTION="Matrices describing affine transformation of the plane."
HOMEPAGE="https://github.com/sgillies/affine"
SRC_URI="$(pypi_sdist_url ${PN^} ${PV})"

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
