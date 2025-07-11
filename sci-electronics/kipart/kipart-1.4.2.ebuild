EAPI=8

PYTHON_COMPAT=( python3_{3,4,5,6,7,8,9,10,11,12,13} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi

DESCRIPTION="Generate multi-unit schematic symbols for KiCad from a CSV file."
HOMEPAGE="https://github.com/devbisme/KiPart"
SRC_URI="$(pypi_sdist_url "${PN}" "${PV}" .tar.gz)"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~arm64 ~ppc ~ppc64"
IUSE="test"

RDEPEND=">=dev-python/affine-1.2.0[${PYTHON_USEDEP}]
         dev-python/pyparsing[${PYTHON_USEDEP}]
         dev-python/openpyxl[${PYTHON_USEDEP}]
         >=dev-python/sexpdata-1.0.0[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
        test? ( dev-python/pytest[${PYTHON_USEDEP}] )"

PATCHES=( "${FILESDIR}/nofuture.patch" )

DISTUTILS_USE_PEP517="setuptools"

python_test() {
        esetup.py test
}

python_prepare_all() {
        # Fix installing 'tests' package in the global scope.
        sed -i -e 's:find_packages(:&exclude=("tests",):' setup.py || die

        distutils-r1_python_prepare_all
}
