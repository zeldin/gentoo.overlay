EAPI=8

DESCRIPTION="NVIDIA Jetson TX2 Accelerated Graphics Driver"
HOMEPAGE="https://developer.nvidia.com/embedded/linux-tegra"
MY_P="Tegra186_Linux_R${PV}"
SRC_URI="http://developer.download.nvidia.com/embedded/L4T/r$(ver_cut 1)_Release_v$(ver_cut 2-)/BSP/${MY_P}_aarch64.tbz2"

SLOT="0"
KEYWORDS="-* arm64"
IUSE="+egl"

RDEPEND="
	~sys-firmware/jetson-tx2-firmware-${PV}
	>=x11-base/xorg-server-1.17.0:=
	>=app-eselect/eselect-opengl-1.3.1:0
"

S="${WORKDIR}/Linux_for_Tegra/nv_tegra"

QA_TEXTRELS_arm64="usr/lib64/tegra/libnvidia-eglcore.so.${PV}
	usr/lib64/tegra/libnvidia-glcore.so.${PV}
	usr/lib64/tegra/libcuda.so.1.1
	usr/lib64/tegra/libGLX_nvidia.so.0
	usr/lib64/tegra/libGL.so.1"


src_unpack() {
    unpack ${A}
    cd "${S}"
    unpack ./nvidia_drivers.tbz2
}

src_install() {
    dodir /etc
    dodir /var
    dodir /usr/bin
    dodir /usr/sbin
    cp -R etc "${D}/" || die "Install failed!"
    cp -R var "${D}/" || die "Install failed!"
    cp -R usr/bin "${D}/usr/" || die "Install failed!"
    cp -R usr/sbin "${D}/usr/" || die "Install failed!"

    sed -i -e 's:^/usr/lib/:/usr/'"$(get_libdir)"'/:' "${D}"/etc/ld.so.conf.d/nvidia-tegra.conf

    exeinto /usr/$(get_libdir)/xorg/modules/drivers
    doexe usr/lib/xorg/modules/drivers/nvidia_drv.so

    dodir /usr/$(get_libdir)/opengl/tegra/extensions
    exeinto /usr/$(get_libdir)/opengl/tegra/extensions
    doexe usr/lib/xorg/modules/extensions/libglx.so

    use egl && mv usr/lib/aarch64-linux-gnu/tegra-egl/*.so.? usr/lib/aarch64-linux-gnu/tegra/
    rm -rf usr/lib/aarch64-linux-gnu/tegra-egl
    cp -R usr/lib/aarch64-linux-gnu/* "${D}/usr/$(get_libdir)/" || die "Install failed!"

    dosym /usr/$(get_libdir)/tegra /usr/$(get_libdir)/opengl/tegra/lib
    dosym libGL.so.1 /usr/$(get_libdir)/tegra/libGL.so
    dosym libcuda.so.1.1 /usr/$(get_libdir)/tegra/libcuda.so.1
}

pkg_postinst() {
        [ "${ROOT}" != "/" ] && return 0

        ldconfig
}
