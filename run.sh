#!/bin/bash
set -euxo pipefail

echo "Downloading tools and kernel"
#set +e
git clone --depth=1 https://github.com/raspberrypi/tools || (cd ./tools; git pull)
git clone --depth=1 https://github.com/raspberrypi/linux || (cd ./linux; git pull)
#set -e

echo PATH=\$PATH:$(pwd)/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin >> ~/.bashrc
source ~/.bashrc

#echo $PATH

echo "Build Config"
cd linux
KERNEL=kernel
make clean 
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- bcmrpi_defconfig

cat >> .config <<- EOF
CONFIG_AUDIT=y
CONFIG_AUDITSYSCALL=y
CONFIG_AUDIT_WATCH=y
CONFIG_AUDIT_TREE=y
# CONFIG_NETLABEL is not set
CONFIG_NETWORK_SECMARK=y
# CONFIG_NF_CONNTRACK_SECMARK is not set
# CONFIG_NETFILTER_XT_TARGET_AUDIT is not set
# CONFIG_NETFILTER_XT_TARGET_SECMARK is not set
# CONFIG_IP_NF_SECURITY is not set
# CONFIG_IP6_NF_SECURITY is not set
# CONFIG_FANOTIFY_ACCESS_PERMISSIONS is not set
# CONFIG_NFSD_V4_SECURITY_LABEL is not set
CONFIG_SECURITY=y
CONFIG_SECURITY_NETWORK=y
# CONFIG_SECURITY_NETWORK_XFRM is not set
# CONFIG_SECURITY_PATH is not set
CONFIG_LSM_MMAP_MIN_ADDR=32768
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE=1
CONFIG_SECURITY_SELINUX_DISABLE=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=0
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_LOADPIN is not set
# CONFIG_SECURITY_YAMA is not set
CONFIG_INTEGRITY=y
# CONFIG_INTEGRITY_SIGNATURE is not set
CONFIG_INTEGRITY_AUDIT=y
# CONFIG_IMA is not set
# CONFIG_EVM is not set
# CONFIG_DEFAULT_SECURITY_SELINUX is not set
CONFIG_AUDIT_GENERIC=y
EOF

echo "Build kernel"
make -j4 ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- zImage modules dtbs

rm -rf ./data
mkdir -p ./data/boot/overlays

echo "Copy compiled kernel and modules into data dir"
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- INSTALL_MOD_PATH=./data/ modules_install

cp arch/arm/boot/zImage data/boot/kernel.img
cp arch/arm/boot/dts/*.dtb data/boot/
cp arch/arm/boot/dts/overlays/*.dtb* data/boot/overlays/
cp arch/arm/boot/dts/overlays/README data/boot/overlays/

