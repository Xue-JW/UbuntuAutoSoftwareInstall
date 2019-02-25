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

youdaoLink="http://codown.youdao.com/cidian/linux/youdao-dict_1.1.0-0-ubuntu_amd64.deb"
teamviewerLink="https://download.teamviewer.com/download/linux/teamviewer_amd64.deb"
nomachineLink="https://download.nomachine.com/download/6.4/Linux/nomachine_6.4.6_1_amd64.deb"
wewechatLink="https://github.com/trazyn/weweChat/releases/download/v1.1.7/wewechat-1.1.7-linux-amd64.deb"

while :
do
	echo && echo -e " 
————————————
${Green_font_prefix} 1.${Font_color_suffix} 有道词典【翻译软件】
${Green_font_prefix} 2.${Font_color_suffix} Git【版本管理】
${Green_font_prefix} 3.${Font_color_suffix} Teamviewer【远程控制】
${Green_font_prefix} 4.${Font_color_suffix} nomachine【远程控制】
${Green_font_prefix} 5.${Font_color_suffix} flameshot【截图软件】
${Green_font_prefix} 6.${Font_color_suffix} Seafile客户端【备份软件】
${Green_font_prefix} 7.${Font_color_suffix} Uget+aria2c【下载器】
${Green_font_prefix} 8.${Font_color_suffix} wewechat【微信客户端】
${Green_font_prefix} 9.${Font_color_suffix} gdebi【deb安装器】
————————————
${Green_font_prefix} 0.${Font_color_suffix} 退出工具安装
————————————" && echo
	echo
	read -e -p " 请输入数字 [0-10]:" num
	case "$num" in
		1)
		youdaoName="youdao.deb"
		sudo wget -O ${youdaoName} -c ${youdaoLink}
		sudo dpkg -i ${youdaoName}
		sudo apt-get -f install -y
		;;
		2)
		sudo apt-fast install git -y
		;;
		3)
		teamviewerName="teamviewer.deb"
		sudo wget -O ${teamviewerName} -c ${teamviewerLink}
		sudo dpkg -i ${teamviewerName}
		sudo apt-get -f install -y
		;;
		4)
		nomachineName="nomachineName.deb"
		sudo wget -O ${nomachineName} -c ${nomachineLink}
		sudo dpkg -i ${nomachineName}
		;;
		5)
		#sudo add-apt-repository ppa:shutter/ppa -y
		#sudo apt-fast update 
		#sudo apt-fast install shutter -y
        apt install flameshot

		;;
		6)
		sudo add-apt-repository ppa:seafile/seafile-client -y
		sudo apt-fast update && sudo apt-fast install seafile-gui -y
		;;
		7)
		sudo apt-fast install uget  -y
		sudo apt-fast install aria2  -y
		;;
		8)
		wewechatName="wewechat.deb"
		sudo wget -O ${wewechatName} -c ${wewechatLink}
		sudo dpkg -i ${wewechatName}
		;;
		0)
		echo "退出安装常用工具"
		exit
		;;
		9)
		sudo apt-fast install gdebi -y
		;;	
		10)
		echo "退出安装常用工具"
		exit
		;;
		*)
		echo "请输入正确数字 [0-10]"
		;;
	esac
	#clear
done
