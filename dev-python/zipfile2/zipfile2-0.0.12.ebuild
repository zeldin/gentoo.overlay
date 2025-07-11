EAPI=8

PYTHON_COMPAT=( python3_{5,6,7,8,9,10,11,12,13} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi

DESCRIPTION="An improved ZipFile class"
HOMEPAGE="https://github.com/cournape/zipfile2"
SRC_URI="$(pypi_sdist_url ${PN^} ${PV})"

LICENSE="PSF-2"
SLOT="0"
KEYWORDS="~arm64 ~ppc ~ppc64"

RDEPEND="${PYTHON_DEPS}
"
DEPEND="${RDEPEND}
        dev-python/setuptools[${PYTHON_USEDEP}]
"
