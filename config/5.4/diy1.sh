#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
#echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
#echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default

echo '添加Passwall/ssrp源'
rm -rf package/lean/luci-app-passwall 
echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default
#rm -rf package/lean/helloworld
#git clone --depth=1 https://github.com/fw876/helloworld.git package/helloworld

echo '添加OpenClash源'
git clone --depth=1 https://github.com/vernesong/OpenClash.git package/OpenClash

#echo '添加Adguardhome源'
rm -rf package/lean/luci-app-adguardhome
#git clone https://github.com/AdguardTeam/AdGuardHome package/AdGuardHome
#echo 'src-git adguardhome https://github.com/kongfl888/luci-app-adguardhome' >>feeds.conf.default

echo '添加Lucky源'
git clone https://github.com/sirpdboy/luci-app-lucky.git package/lucky

echo '添加jerrykuku的argon-mod主题'
rm -rf package/lean/luci-theme-argon  
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon package/lean/luci-theme-argon

echo '添加3rd源'
#git clone https://github.com/siropboy/sirpdboy-package package/sirpdboy-package
#git clone https://github.com/kenzok8/small-package package/kenzok8-package
# echo 'src-git liuran001 https://github.com/liuran001/openwrt-packages' >>feeds.conf.default
# echo 'src-git kiddin9 https://github.com/kiddin9/openwrt-packages' >>feeds.conf.default
# echo 'src-git small8 https://github.com/kenzok8/small-package' >>feeds.conf.default
echo 'src-git sirpdboy https://github.com/sirpdboy/sirpdboy-package' >>feeds.conf.default

echo '添加lwz322的K3屏幕驱动'
rm -rf package/lean/luci-app-k3screenctrl
git clone https://github.com/yangxu52/luci-app-k3screenctrl.git package/lean/luci-app-k3screenctrl
rm -rf package/lean/k3screenctrl
git clone https://github.com/yangxu52/k3screenctrl_build.git package/lean/k3screenctrl

#echo '移除bcm53xx中的其他机型'
#sed -i '421,453d' target/linux/bcm53xx/image/Makefile
#sed -i '140,412d' target/linux/bcm53xx/image/Makefile
#sed -i 's/$(USB3_PACKAGES) k3screenctrl/luci-app-k3screenctrl/g' target/linux/bcm53xx/image/Makefile
# sed -n '140,146p' target/linux/bcm53xx/image/Makefile

echo '更改bcm53xx makefile，只编译k3固件(先注释所有的TARGET_开头的行，再把phicomm_k3这行打开)'
sed -i 's|^TARGET_|# TARGET_|g; s|# TARGET_DEVICES += phicomm_k3|TARGET_DEVICES += phicomm_k3|' target/linux/bcm53xx/image/Makefile

echo '移除USB3驱动？'
sed -i 's/$(USB3_PACKAGES) k3screenctrl/luci-app-k3screenctrl/g' target/linux/bcm53xx/image/Makefile

echo '替换无线驱动'1.'asus_dhd24' 2.'ac88u_20' 3.'69027'
firmware='69027'
wget -nv https://github.com/yangxu52/Phicomm-k3-Wireless-Firmware/raw/master/brcmfmac4366c-pcie.bin.${firmware} -O package/lean/k3-brcmfmac4366c-firmware/files/lib/firmware/brcm/brcmfmac4366c-pcie.bin
