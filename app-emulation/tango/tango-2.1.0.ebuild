EAPI=8
inherit linux-mod-r1

DESCRIPTION="Tango is a binary translation system for GNU/Linux and Android which allows unmodified 32-bit ARM programs to run on 64-bit only ARM processors"
HOMEPAGE="https://www.amanieusystems.com/home"
SRC_URI="tango-v${PV}-integration-package.zip"

LICENSE="Amanieu"
SLOT="0"
KEYWORDS="~arm64 -*"
RESTRICT="fetch"

QA_PREBUILT="usr/bin/tango*"

S="${WORKDIR}/tango-v${PV}-integration-package"

PATCHES=( "${FILESDIR}"/fd_access.patch )

src_configure() {
  for f in tango binfmt.conf; do
    sed -i -e 's;/usr/local/;/usr/;g' "${S}/linux/files/${f}"
  done
}

src_compile() {
  MODULE_MAKEARGS+=(
    KERNEL_SRC="${KV_OUT_DIR}"
  )

  emake -C kernel-module "${MODULE_MAKEARGS[@]}"
}

src_install() {
  linux_domodule kernel-module/tango32.ko
  modules_post_process  
  insinto /etc/modules-load.d
  newins - tango32.conf <<<"tango32"
  cd "${S}/linux/files"
  dobin tango
  dobin tango_translator
  dobin tango_pretranslator
  dobin tango-coredump
  dobin tango-coredump-pipe
  dodoc NOTICE.txt
  dodoc THIRD_PARTY.html
  insinto /usr/share/${PN}/
  doins binfmt.conf
  doinitd "${FILESDIR}/tango-binfmt"
}
