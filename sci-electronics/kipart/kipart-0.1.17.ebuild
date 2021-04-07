EAPI=5

PYTHON_COMPAT=( python3_{3,4,5,6,7,8} )

inherit distutils-r1 eutils

DESCRIPTION="Generate multi-unit schematic symbols for KiCad from a CSV file."
HOMEPAGE="https://github.com/xesscorp/KiPart"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~arm64 ~ppc ~ppc64"
IUSE="test"

RDEPEND=">=dev-python/future-0.15.0[${PYTHON_USEDEP}]
         >=dev-python/affine-1.2.0[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
        test? ( dev-python/pytest[${PYTHON_USEDEP}] )"

python_test() {
        esetup.py test
}

python_prepare_all() {
        # Fix installing 'tests' package in the global scope.
        sed -i -e 's:find_packages(:&exclude=("tests",):' setup.py || die

        distutils-r1_python_prepare_all
}
