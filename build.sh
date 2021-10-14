#!/bin/bash

git clone git://git.ti.com/k3-image-gen/k3-image-gen.git
cd ./k3-image-gen/
make SOC=j721e CROSS_COMPILE=arm-linux-gnueabihf-
mv sysfw.itb ../
cd ../

git clone https://github.com/ARM-software/arm-trusted-firmware.git
cd ./arm-trusted-firmware/
make CROSS_COMPILE=aarch64-linux-gnu- ARCH=aarch64 PLAT=k3 TARGET_BOARD=generic SPD=opteed
mv build/k3/generic/release/bl31.bin ../
cd ../

git clone https://github.com/OP-TEE/optee_os.git
cd ./optee_os/
make PLATFORM=k3-j721e CFG_ARM64_core=y
mv out/arm-plat-k3/core/tee-pager_v2.bin ../
cd ../

git clone -b v2021.01-ti-08.00.00.004 https://github.com/beagleboard/u-boot
cd ./u-boot/
make CROSS_COMPILE=arm-linux-gnueabihf- j721e_evm_r5_defconfig O=/tmp/r5
make -j4 CROSS_COMPILE=arm-linux-gnueabihf- O=/tmp/r5
mv /tmp/r5/tiboot3.bin ../
make CROSS_COMPILE=aarch64-linux-gnu- j721e_evm_a72_defconfig O=/tmp/a72
make -j4 CROSS_COMPILE=aarch64-linux-gnu- ATF=../bl31.bin TEE=../tee-pager_v2.bin DM=/opt/u-boot/bb-u-boot-j721e-evm/ipc_echo_testb_mcu1_0_release_strip.xer5f O=/tmp/a72
mv /tmp/a72/tispl.bin ../
mv /tmp/a72/u-boot.img ../
cd ../