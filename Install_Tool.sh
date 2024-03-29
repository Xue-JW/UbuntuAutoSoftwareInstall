#!/bin/bash

#=================================================
#	System Required: Ubuntu16.04 x64
#	Description: Software install automatic
#	Version: 0.0.1
#	Author: Gavin
#	Blog: 
#=================================================

cd "${package_path}"
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
${Green_font_prefix} 10.${Font_color_suffix} Synergy Pro【多电脑共用一套鼠键】
${Green_font_prefix} 11.${Font_color_suffix}【利用translate-shell做的轻量翻译小工具】 new~！
————————————
${Green_font_prefix} 0.${Font_color_suffix} 退出工具安装
————————————" && echo
	echo
	read -e -p " 请输入数字 [0-10]:" num
	case "$num" in
		1)
		youdaoName="youdao.deb"
		wget -O ${youdaoName} -c ${youdaoLink}
		sudo dpkg -i ${youdaoName}
		sudo apt-get -f install -y
		;;
		2)
		sudo apt install git -y
		;;
		3)
		teamviewerName="teamviewer.deb"
		wget -O ${teamviewerName} -c ${teamviewerLink}
		sudo dpkg -i ${teamviewerName}
		sudo apt-get -f install -y
		;;
		4)
		nomachineName="nomachineName.deb"
		wget -O ${nomachineName} -c ${nomachineLink}
		sudo dpkg -i ${nomachineName}
		sudo apt-get -f install -y
		;;
		5)
		#sudo add-apt-repository ppa:shutter/ppa -y
		#sudo apt update 
		#sudo apt install shutter -y
        	sudo apt install flameshot
		sudo python3 ./add_shortcut.py "flameshot" "flameshot-gui" "<Control>Print"
		echo "脚本已设置使用<Ctrl+Print>键启动截图，如无效需重启生效"
		;;
		6)
		sudo add-apt-repository ppa:seafile/seafile-client -y
		sudo apt update && sudo apt install seafile-gui -y
		;;
		7)
		sudo apt install uget  -y
		sudo apt install aria2  -y
		;;
		8)
		wewechatName="wewechat.deb"
		wget -O ${wewechatName} -c ${wewechatLink}
		sudo dpkg -i ${wewechatName}
		sudo apt-get -f install -y
		;;
		0)
		echo "退出安装常用工具"
		exit
		;;
		9)
		sudo apt install gdebi -y
		;;	
		10)
		echo -e "\nSynergy Pro\n\n下载地址:https://www.lanzous.com/i3pou2j\n\n网盘密码为:318"
		;;
		11)
		sudo apt install xsel xclip -y
		sudo apt install libnotify-bin -y
		sudo apt install translate-shell -y
		cp "${filepath}"/setting_file/copytrans.sh ${package_path}/copytrans.sh
		sudo chmod +x ${package_path}/copytrans.sh
		sudo python3 ./add_shortcut.py "copytran" "bash ${package_path}/copytrans.sh" "<Control>1"
		echo "脚本已设置使用<Ctrl+1>键翻译剪切板内容，如无效需重启生效"
		;;
		*)
		echo "请输入正确数字 [0-10]"
		;;
	esac
	#sudo chmod 777 ${package_path} -R
	# clear
done
