#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

echo '修改默认管理IP'
sed -i 's/192.168.1.1/192.168.11.1/g' package/base-files/files/bin/config_generate

echo '修改主机名'
sed -i "s/hostname='OpenWrt'/hostname='K3'/g" package/base-files/files/bin/config_generate
cat package/base-files/files/bin/config_generate |grep hostname=

echo '修改内核Kernel版本为5.10/5.15，默认为5.4'
#sed -i 's/KERNEL_PATCHVER:=*.*/KERNEL_PATCHVER:=5.4/g' target/linux/bcm53xx/Makefile
#sed -i 's/KERNEL_PATCHVER:=*.*/KERNEL_PATCHVER:=5.10/g' target/linux/bcm53xx/Makefile
sed -i 's/KERNEL_PATCHVER:=*.*/KERNEL_PATCHVER:=5.15/g' target/linux/bcm53xx/Makefile
cat target/linux/bcm53xx/Makefile |grep KERNEL_PATCHVER

echo '移除登陆密码'
sed -i 's/$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.//g' openwrt/package/lean/default-settings/files/zzz-default-settings

echo 'TTYD自动登录'
sed -i 's/\/bin\/login/\/bin\/login -f root/' /etc/config/ttyd && reboot

#echo '移除主页跑分信息显示'
#sed -i 's/ <%=luci.sys.exec("cat \/etc\/bench.log") or ""%>//g' package/lean/autocore/files/arm/index.htm

#echo '移除主页日志打印'
#sed -i '/console.log(mainNodeName);/d' package/lean/luci-theme-argon/htdocs/luci-static/argon/js/script.js

#echo '修改upnp绑定文件位置'
#sed -i 's/\/var\/upnp.leases/\/tmp\/upnp.leases/g' feeds/packages/net/miniupnpd/files/upnpd.config
#cat feeds/packages/net/miniupnpd/files/upnpd.config |grep upnp_lease_file