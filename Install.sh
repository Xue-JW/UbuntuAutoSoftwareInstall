#!/bin/bash

#PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
#export PATH

#=================================================
#	System Required: Ubuntu16.04 x64
#	Description: Software install automatic
#	Version: 0.0.3
#	Author: Gavin
#	Blog: 
#=================================================

sh_ver="0.0.3"
filepath=$(cd "$(dirname "$0")"; pwd)
package_path=~/Downloads/Software_Package
zh_package_path=~/下载/Software_Package
setting_path=$(cd "$(dirname "$0")"; pwd)/setting_file
user_id=$(whoami)

# create download dir
[ $LANG == "zh_CN.UTF-8" ] && package_path=$zh_package_path
export filepath package_path setting_path user_id

if [ ! -e ${package_path} ]
then
	mkdir ${package_path}
	sudo chmod 777 ${package_path} -R
fi


# add proxy in terminal
#export http_proxy=proxy_addr:port
#export https_proxy=proxy_addr:port
#export ftp_proxy=proxy_addr:port

# set time-zone
sudo timedatectl set-local-rtc true
sudo timedatectl set-ntp true

Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && Font_color_suffix="\033[0m"
Info="${Green_font_prefix}[信息]${Font_color_suffix}"
Error="${Red_font_prefix}[错误]${Font_color_suffix}"
Tip="${Green_font_prefix}[注意]${Font_color_suffix}"

export Green_font_prefix Red_font_prefix Green_background_prefix Red_background_prefix Font_color_suffix

check_root(){
	[ $EUID != 0 ] && echo -e "${Error} 当前非ROOT账号(或没有ROOT权限)，无法继续操作，请更换ROOT账号或使用 ${Green_background_prefix}sudo su${Font_color_suffix} 命令获取临时ROOT权限（执行后可能会提示输入当前账号的密码）。" && exit 1
}

check_source(){
	[ $release == 'ubuntu' ] && echo -e "${Info} I don't kown your ubuntu release and will add ubuntu 16.04 sourcefile into system setting"
	[ $release == 'ubuntu_16' ] && FILE=${setting_path}/ubuntu_16_source_list.txt
	[ $release == 'ubuntu_18' ] && FILE=${setting_path}/ubuntu_18_source_list.txt
	export FILE
	#echo $FILE

	if [ `grep -c '# add tsinghua mirrors end' /etc/apt/sources.list` -eq '0' ];then
		echo "添加软件源:
------aliyun(28ms)***tsinghua(35ms)***163(30ms)***ustc(26ms-edu)------"
		sudo cp /etc/apt/sources.list /etc/apt/sources.list.old
		sudo -E bash -c '
		echo "###add custom mirrors###" > /etc/apt/sources.list
		while read -r line;do
			echo ${line} >> /etc/apt/sources.list
		done < ${FILE}
		'
		sudo apt update -y

		#sudo apt upgrade -y
		#sudo apt full-upgrade -y
		#sudo apt install fastitude -y # 相比apt能自动解决依赖问题
		echo "添加软件源完成"
	else
		echo "mirrors has added"
	fi
}

check_downloader(){

	#if [ ! -e "/usr/sbin/apt-fast" ]
	#then
	#   	sudo add-apt-repository ppa:apt-fast/stable -y
	#	sudo apt-get update
	#	sudo apt-get -y install apt-fast
	#fi

	if [ ! -e "/usr/share/build-essential" ]
	then
		sudo apt install build-essential
	fi

	if [ ! -e "/usr/bin/wget" ]
	then
	   sudo apt install wget
	fi

	if [ ! -e "/usr/bin/curl" ]
	then
	   sudo apt install curl
	fi

	if [ ! -e "/usr/bin/pip" ]
	then
	   sudo apt install python-pip python-dev
	fi
}

# 是否所有安装脚本都在
check_script_complete(){
	if [[ !(-e "${filepath}/Install_System_Software.sh" &&
	-e "${filepath}/Install_Viewer.sh" &&
	-e "${filepath}/Install_Work_Software.sh" &&
	-e "${filepath}/Install_Tool.sh" &&
	-e "${filepath}/Install_Beauty.sh" &&
	-e "${filepath}/install_ros_kinetic.sh") ]];
	then
		echo -e "${Red_font_prefix}***脚本文件不完整,请确认是否遗漏***${Font_color_suffix}
		同目录下包含Install_System_Software，Install_Viewer，Install_Work_Software，Install_Tool，Install_Beauty共5个脚本"
	else
		sudo chmod +x ${filepath}/Install_System_Software.sh ${filepath}/Install_Viewer.sh ${filepath}/Install_Work_Software.sh ${filepath}/Install_Tool.sh ${filepath}/Install_Beauty.sh
	fi
}

#检查系统
check_sys(){
	if [[ -f /etc/redhat-release ]]; then
		release="centos"
	elif cat /etc/issue | grep -q -E -i "debian"; then
		release="debian"
	elif cat /etc/issue | grep -q -E -i "ubuntu"; then
		release="ubuntu"
		if [ `grep -c '18' /etc/issue` -eq '1' ];then 
			release="ubuntu_18";
		elif [ `grep -c '16' /etc/issue` -eq '1' ];then 
			release="ubuntu_16"
		fi
	elif cat /etc/issue | grep -q -E -i "centos|red hat|redhat"; then
		release="centos"
	elif cat /proc/version | grep -q -E -i "debian"; then
		release="debian"
	elif cat /proc/version | grep -q -E -i "ubuntu"; then
		release="ubuntu"
	elif cat /proc/version | grep -q -E -i "centos|red hat|redhat"; then
		release="centos"
	fi
	bit=`uname -m`
	[ $release != 'ubuntu' ] && [ $release != 'ubuntu_16' ] && [ $release != 'ubuntu_18' ] && echo -e "${Error} this Script only for unbuntu now" && exit 1
}

uninstall_sys_app(){
	sudo apt remove thunderbird -y
	sudo apt remove totem -y
	sudo apt remove rhythmbox -y
	sudo apt remove empathy   -y
	sudo apt remove brasero -y
	sudo apt remove simple-scan -y
	sudo apt remove gnome-mahjongg  -y
	sudo apt remove aisleriot  -y
	sudo apt remove gnome-mines  -y
	sudo apt remove transmission-common  -y
	sudo apt remove gnome-orca  -y
	sudo apt remove webbrowser-app  -y
	sudo apt remove gnome-sudoku -y
	sudo apt remove libreoffice-common -y
	sudo apt clean
}



####################################
clear
#check_root
check_script_complete
check_sys


while :
do
echo -e "  
————————————
Ubuntu软件一键安装脚本 ${Red_font_prefix}[v${sh_ver}]${Font_color_suffix}
-- Gavin | for Lab317&318 --

本脚本只在Ubuntu16.04 64位系统验证，其他系统未经测试不确保可用，当前系统为： ${Green_font_prefix}${release} ${bit}${Font_color_suffix}
脚本文件路径：${Green_font_prefix}${filepath}${Font_color_suffix}
安装包保存路径:${Green_font_prefix}${package_path}${Font_color_suffix}

${Green_font_prefix} 10.${Font_color_suffix}更新 软件源与安装安装器${Green_background_prefix}【首次执行必选】${Font_color_suffix}
————————————
${Green_font_prefix} 1.${Font_color_suffix} 安装 必备软件
${Green_font_prefix} 2.${Font_color_suffix} 安装 文件浏览软件
${Green_font_prefix} 3.${Font_color_suffix} 安装 科研工具
${Green_font_prefix} 4.${Font_color_suffix} 安装 常用工具
${Green_font_prefix} 5.${Font_color_suffix} 安装 系统美化软件
————————————
${Green_font_prefix} 6.${Font_color_suffix} 升级 本脚本 #
${Green_font_prefix} 7.${Font_color_suffix} 设置 Shadowsock #
${Green_font_prefix} 8.${Font_color_suffix} 生成 ssh key #
${Green_font_prefix} 9.${Font_color_suffix} 卸载 多余系统自带软件
————————————
${Green_font_prefix} 0.${Font_color_suffix} 退出 本脚本
————————————
" && echo
	echo
	read -e -p " 请输入数字 [0-10]:" num
	case "$num" in
		1)
		${filepath}/Install_System_Software.sh
		;;
		2)
		${filepath}/Install_Viewer.sh
		;;
		3)
		${filepath}/Install_Work_Software.sh
		;;
		4)
		${filepath}/Install_Tool.sh
		;;
		5)
		${filepath}/Install_Beauty.sh
		;;
		6)
		${filepath}/Update_Shell.sh
		;;
		7)
		echo "Null"
		;;
		8)
		# generate github ssh public key
		while getopts "g: b: c:" arg #选项后面的冒号表示该选项需要参数
		do
			case $arg in
				 g)
					echo "a's arg:$OPTARG" #参数存在$OPTARG中
					# configure github ssh public key
					ssh-keygen -t rsa -b 4096 -C "$OPTARG"
					eval "$(ssh-agent -s)"
					ssh-add ~/.ssh/id_rsa
					sudo apt install xclip
					xclip -sel clip < ~/.ssh/id_rsa.pub
					cat ~/.ssh/id_rsa > ~/desktop/github_ssh_key.txt
					eval "$(ssh-agent -s)"
					ssh-add
					;;
				 b)
					echo "b's arg:$OPTARG"
					;;
				 c)
					echo "c"
					;;
				 ?) #当有不认识的选项的时候arg为?
				echo "unkonw argument"
			exit 1
			;;
			esac
		done
		;;
		9)
		uninstall_sys_app
		;;
		0)
		sudo chmod 777 ${package_path} -R
		echo "退出脚本，感谢使用"
		exit
		;;
		10)
		check_source
		check_downloader
		;;
		*)
		echo "请输入正确数字 [0-10]"
		;;
	esac
	sudo chmod 777 ${package_path} -R
    	clear
	cd ${filepath}
done

