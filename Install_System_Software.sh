#!/bin/bash

#=================================================
#	System Required: Ubuntu16.04 x64
#	Description: Software install automatic
#	Version: 0.0.1
#	Author: Gavin
#	Blog: 
#=================================================

cd ${package_path}
clear
echo -e "开始软件安装，请选择需要安装的软件"

sougouLink="https://pinyin.sogou.com/linux/download.php?f=linux&bit=64"
lanternLink="https://raw.githubusercontent.com/getlantern/lantern-binaries/master/lantern-installer-64-bit.deb"
ssqtLink="https://github.com/shadowsocks/shadowsocks-qt5/releases/download/v3.0.1/Shadowsocks-Qt5-3.0.1-x86_64.AppImage"
while :
do
	echo -e " 
————————————
 ${Green_font_prefix} 1.${Font_color_suffix} 搜狗输入法
 ${Green_font_prefix} 2.${Font_color_suffix} Google输入法
 ${Green_font_prefix} 3.${Font_color_suffix} lantern
 ${Green_font_prefix} 4.${Font_color_suffix} Shadowsocks-qt5
 ${Green_font_prefix} 5.${Font_color_suffix} NVIDIA驱动
 ${Green_font_prefix} 6.${Font_color_suffix} ssh key #
 ${Green_font_prefix} 7.${Font_color_suffix} 
————————————
 ${Green_font_prefix} 0.${Font_color_suffix} 退出工具安装
————————————" && echo
	echo
	read -e -p " 请输入数字 [0-10]:" num
	case "$num" in
		1)
		if [ ! -e "/usr/bin/fcitx" ]
		then
			sudo add-apt-repository ppa:fcitx-team/nightly -y
			sudo apt-fast update
			sudo apt-fast install fcitx fcitx-libs -y
			sudo apt-fast install fcitx-config-gtk  -y
			sudo apt-fast install fcitx-table-all -y
			sudo apt-fast install im-switch -y
			sudo add-apt-repository -r ppa:fcitx-team/nightly -y  # tooo slow in China,remove afer install
		fi
		sougouName="sougoupinyi.deb"
		sudo wget -O ${sougouName} -c ${sougouLink}
		sudo dpkg -i ${sougouName}
		sudo apt-fast -f -y install # install depend
		
		echo -e "输入法切换可参考：https://jingyan.baidu.com/article/adc815134f4b92f722bf7350.html?qq-pf-to=pcqq.c2c"
		# sudo dpkg -i sogoupinyin_amd64.deb
		# sudo apt-fast -f -y install
		# sudo dpkg -i sogoupinyin_amd64.deb
		;;
		2)
		sudo apt-fast install fcitx fcitx-googlepinyin fcitx-module-cloudpinyin -y
		;;
		3)
		lanternName="lantern.deb"
		sudo wget -O ${lanternName} -c ${lanternLink}
		sudo dpkg -i ${lanternName}
		;;
		4)
		ssqtName="Shadowsock_qt.AppImage"
		sudo wget -O ${ssqtName} -c ${ssqtLink}
		sudo chmod +x ${ssqtName}
		echo "软件已下载至${package_path}/${ssqtName},双击即可打开运行，在添加时通过选择扫描屏幕二维码即可完成配置，chrome配置与Windows相同
[enter to continue]"
		read
		;;
		5)
		sudo add-apt-repository ppa:graphics-drivers/ppa -y
		sudo apt update
		echo "********************当前显卡驱动型号及可安装版本****************************"
		ubuntu-drivers devices
		echo "***************************************************************************"
		sudo ubuntu-drivers autoinstall
		;;
		6)
		echo "null"
		;;
		7)
		echo "null"
		;;
		8)
		
		;;
		0)
		echo "退出安装系统软件"
		exit
		;;
		9)
		echo "退出安装系统软件"
		exit
		;;
		*)
		echo "请输入正确数字 [0-10]"
		;;
	esac
	clear
done
