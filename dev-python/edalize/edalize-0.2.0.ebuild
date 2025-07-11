EAPI=8

PYTHON_COMPAT=( python3_{5,6,7,8,9,10,11,12} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi

DESCRIPTION="An abstraction library for interfacing EDA tools"
HOMEPAGE="https://github.com/olofk/edalize"
SRC_URI="$(pypi_sdist_url ${PN^} ${PV})"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~arm64 ~ppc ~ppc64"

RDEPEND="${PYTHON_DEPS}
	>=dev-python/pytest-3.3.0[${PYTHON_USEDEP}]
	>=dev-python/jinja2-2.8[${PYTHON_USEDEP}]
	|| ( <dev-python/jinja2-2.11[${PYTHON_USEDEP}]
	     >=dev-python/jinja2-2.11.2[${PYTHON_USEDEP}] )
"
DEPEND="${RDEPEND}
        dev-python/setuptools[${PYTHON_USEDEP}]
"
