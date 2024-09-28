EAPI=7

inherit versionator

DESCRIPTION="NVIDIA Jetson TX2 Accelerated Graphics Driver"
HOMEPAGE="https://developer.nvidia.com/embedded/linux-tegra"
MY_P="jetson_linux_r${PV}"
SRC_URI="http://developer.nvidia.com/downloads/embedded/l4t/r$(get_major_version)_release_v$(get_after_major_version)/t186/${MY_P}_aarch64.tbz2"

SLOT="0"
KEYWORDS="-* arm64"

RDEPEND="
	~sys-firmware/jetson-tx2-firmware-${PV}
	>=x11-base/xorg-server-1.17.0:=
	>=media-libs/libglvnd-1.3.1:0
"
DEPEND="|| ( <app-arch/bzip2-1.0.6 >=app-arch/bzip2-1.0.8 )"

S="${WORKDIR}/Linux_for_Tegra/nv_tegra"

QA_TEXTRELS_arm64="usr/lib64/tegra/libnvidia-eglcore.so.${PV}
	usr/lib64/tegra/libnvidia-glcore.so.${PV}
	usr/lib64/tegra/libcuda.so.1.1
	usr/lib64/tegra/libGLX_nvidia.so.0"


src_unpack() {
    unpack ${A}
    cd "${S}"
    unpack ./nvidia_drivers.tbz2
}

src_install() {
    for f in etc/vulkan/icd.d/nvidia_icd.json usr/share/glvnd/egl_vendor.d/10_nvidia.json usr/lib/aarch64-linux-gnu/tegra/*.so usr/lib/aarch64-linux-gnu/*.so ; do
	target=$(readlink "$f" | sed -ne "s:/lib/aarch64-linux-gnu/:/$(get_libdir)/:p")
	if [ -n "${target}" ]; then
	    ln -s -f "${target}" "$f"
	fi
    done

    dodir /etc
    dodir /var
    dodir /usr/bin
    dodir /usr/sbin
    dodir /usr/share
    cp -R etc "${D}/" || die "Install failed!"
    cp -R var "${D}/" || die "Install failed!"
    cp -R usr/bin "${D}/usr/" || die "Install failed!"
    cp -R usr/sbin "${D}/usr/" || die "Install failed!"
    cp -R usr/share "${D}/usr/" || die "Install failed!"

    sed -i -e 's:^/usr/lib/:/usr/'"$(get_libdir)"'/:' "${D}"/etc/ld.so.conf.d/nvidia-tegra.conf

    exeinto /usr/$(get_libdir)/xorg/modules/drivers
    doexe usr/lib/xorg/modules/drivers/nvidia_drv.so
    exeinto /usr/$(get_libdir)/xorg/modules/extensions
    doexe usr/lib/xorg/modules/extensions/libglxserver_nvidia.so

    cp -R usr/lib/aarch64-linux-gnu/* "${D}/usr/$(get_libdir)/" || die "Install failed!"

    dosym tegra/libcuda.so /usr/$(get_libdir)/libcuda.so
    dosym libcuda.so.1.1 /usr/$(get_libdir)/tegra/libcuda.so.1

    dosym libv4l2.so.0  /usr/$(get_libdir)/libv4l2.so
    dosym libv4lconvert.so.0 /usr/$(get_libdir)/libv4lconvert.so
    dosym libvulkan.so.1  /usr/$(get_libdir)/libvulkan.so
}

pkg_postinst() {
        [ "${ROOT}" != "/" ] && return 0

        ldconfig
}
