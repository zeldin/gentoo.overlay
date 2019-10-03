DESCRIPTION="Dictionary for xjdic"
URI="http://ftp.monash.edu.au/pub/nihongo/${PN}.gz"
LICENSE="CC-BY-SA-3.0"
SLOT="0"
KEYWORDS=""
PROPERTIES="live"
DEPEND="net-misc/wget app-dicts/xjdic"

src_unpack() {
   wget -N ${URI}
   unpack ./${PN}.gz
}

src_compile () {
    xjdxgen ${PN} || die
}

src_install () {
    insinto /usr/share/xjdic
    doins ${PN}
    doins ${PN}.xjdx
}
