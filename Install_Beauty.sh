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

while :
do
	echo -e " 
美化参考：https://juejin.im/entry/59d5fabc5188257e78531cdb
————————————
${Green_font_prefix} 1.${Font_color_suffix} conky【边栏信息】
${Green_font_prefix} 2.${Font_color_suffix} Docky【底栏】
${Green_font_prefix} 3.${Font_color_suffix} Unity Tweak Tool【系统主题设置】
${Green_font_prefix} 4.${Font_color_suffix} indicator-multiload 【状态栏显示系统信息】
${Green_font_prefix} 5.${Font_color_suffix} cairo-dock【底栏】【推荐】
${Green_font_prefix} 6.${Font_color_suffix} flatabulous-theme+MacUbuntu【主题】
${Green_font_prefix} 7.${Font_color_suffix} gnome-tweak-tool【系统主题设置】
————————————
${Green_font_prefix} 0.${Font_color_suffix} 退出美化工具安装
————————————" && echo
	echo
	read -e -p " 请输入数字 [0-10]:" num
	case "$num" in
		1)
		sudo apt install curl -y
		sudo apt install conky conky-all -y
		;;
		2)
		sudo add-apt-repository ppa:docky-core/stable -y
		sudo apt update && sudo apt install docky -y
		;;
		3)
		sudo apt install unity-tweak-tool -y
		;;
		4)
		sudo apt install -y indicator-multiload
		;;
		5)
		sudo apt install cairo-dock -y
		;;
		6)
		sudo add-apt-repository ppa:noobslab/themes -y
		sudo add-apt-repository ppa:snwh/pulp -y
		sudo add-apt-repository ppa:noobslab/icons -y
		sudo add-apt-repository ppa:noobslab/macbuntu -y		
		sudo apt update
		sudo apt install unity-tweak-tool -y
		sudo apt install flatabulous-theme -y
		sudo apt install ultra-flat-icons -y
		sudo apt install paper-icon-theme -y
		sudo apt install macbuntu-os-icons-lts-v7 -y
		sudo apt install macbuntu-os-ithemes-lts-v7 -y
		echo "安装完成，打开Unity Tweak Tool切换"
		;;
		7)
		sudo apt install gnome-tweak-tool  -y
		;;
		8)
		echo "null"
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
	#sudo chmod 777 ${package_path} -R
	clear
done
