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
		ss_qtName="Shadowsock_qt.AppImage"
		ss_cfgpath=~/.config/shadowsocks-qt5
		ss_startpath=~/.config/autostart
		ss_autostart="[Desktop Entry]\n
				Name=Shadowsocks-Qt5\n
				Exec=${package_path}/${ss_qtName}\n
				Type=Application\n
				Terminal=false\n
				X-GNOME-Autostart-enabled=true\n"
		#sudo apt-fast install screen
		sudo wget -O ${ss_qtName} -c ${ssqtLink}
		sudo chmod +x ${ss_qtName}
		sudo -H pip install -U genpac  # 全局pac代理
		

		if [[ !(-e "${setting_path}/ss_config.ini") ]];
		then
			echo "软件已下载至${package_path}/${ss_qtName},双击即可打开运行,启动后右键右上角绿色纸飞机进行设置,具体配置参考之前的文档"
		else
			sudo mkdir ${ss_cfgpath}
			sudo chmod 777 ${ss_cfgpath} -R
			cp ${setting_path}/ss_config.ini ${ss_cfgpath}/config.ini
			sudo chmod 666 ${ss_cfgpath}/config.ini
			echo "软件已下载至${package_path}/${ss_qtName}并配置完成,双击即可打开运行"
		fi
		#nohup ${package_path}/${ss_qtName} &
		nohup ${package_path}/${ss_qtName}>${package_path}/ss.out  2>&1 &
		#screen -d -m -s ss ${package_path}/${ss_qtName}	
		#setsid	${package_path}/${ss_qtName} &
		#mkdir ${ss_startpath}
		echo -e ${ss_autostart} > ${ss_startpath}/shadowsocks-qt5.desktop
		sudo chmod 666 ${ss_startpath}/shadowsocks-qt5.desktop

		genpac --pac-proxy "SOCKS5 127.0.0.1:6666" --gfwlist-proxy="SOCKS5 127.0.0.1:6666" --output="autoproxy.pac" --gfwlist-url="https://raw.githubusercontent.com/gfwlist/gfwlist/master/gfwlist.txt"
		sudo gsettings set org.gnome.system.proxy mode auto
		sudo gsettings set org.gnome.system.proxy autoconfig-url "file://${package_path}/autoproxy.pac"
		echo "已打开SS并设为开机自启动.[Press any key to continue],可打开浏览器测试"
		#read
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
	#clear
done
