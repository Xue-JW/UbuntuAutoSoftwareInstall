#!/bin/bash

#=================================================
#	System Required: Ubuntu16.04 x64
#	Description: Software install automatic
#	Version: 0.0.1
#	Author: Gavin
#	Blog: 
#=================================================

cd "${package_path}"
echo -e "开始软件安装，请选择需要安装的软件"

qtLink="https://mirrors.tuna.tsinghua.edu.cn/qt/official_releases/qt/5.10/5.10.0/qt-opensource-linux-x64-5.10.0.run"
vscodeLink="https://go.microsoft.com/fwlink/?LinkID=760868"
anacondaLink="https://mirrors.tuna.tsinghua.edu.cn/anaconda/archive/Anaconda3-5.3.1-Linux-x86_64.sh"
robowareLink="https://github.com/TonyRobotics/RoboWare/raw/master/Studio/roboware-studio_1.2.0-1524709819_amd64.deb"
mendeleyLink="https://www.mendeley.com/repositories/ubuntu/stable/amd64/mendeleydesktop-latest"
virtualboxLink="https://download.virtualbox.org/virtualbox/6.0.2/virtualbox-6.0_6.0.2-128162~Ubuntu~xenial_amd64.deb"
QGCLink="https://s3-us-west-2.amazonaws.com/qgroundcontrol/latest/QGroundControl.AppImage"
while :
do
clear
	echo -e " 
————————————
${Green_font_prefix} 1.${Font_color_suffix} QT 5.10.0
${Green_font_prefix} 2.${Font_color_suffix} VS code
${Green_font_prefix} 3.${Font_color_suffix} ROS kinetic
${Green_font_prefix} 4.${Font_color_suffix} Roboware Studio
${Green_font_prefix} 5.${Font_color_suffix} Anaconda
${Green_font_prefix} 6.${Font_color_suffix} Pycharm
${Green_font_prefix} 7.${Font_color_suffix} Mendeley
${Green_font_prefix} 8.${Font_color_suffix} virtualbox虚拟机
${Green_font_prefix} 9.${Font_color_suffix} Matlab #
${Green_font_prefix} 10.${Font_color_suffix} tensorflow #
${Green_font_prefix} 11.${Font_color_suffix} tensorflow-cpu #
${Green_font_prefix} 12.${Font_color_suffix} caffe #
${Green_font_prefix} 13.${Font_color_suffix} pytorch 
${Green_font_prefix} 14.${Font_color_suffix} QGroundControl
————————————
${Green_font_prefix} 0.${Font_color_suffix} 退出安装
————————————" && echo
	echo
	read -e -p " 请输入数字 [0-10]:" num
	case "$num" in
		1)
		sudo apt install build-essential libgl1-mesa-dev -y
		sudo apt install g++ -y
		qtName="qt_5_10_0.run"
		wget -O ${qtName} -c ${qtLink}
		chmod +x ./${qtName}
		./${qtName}
		;;
		2)
		vscodeName="vsCode.deb"
		wget -O ${vscodeName} -c ${vscodeLink}
		sudo dpkg -i ${vscodeName}
		sudo apt-get -f install -y
		;;
		3)
		chmod +x ${filepath}/install_ros_kinetic.sh
		${filepath}/install_ros_kinetic.sh
		;;
		4)
		sudo apt install python-pip -y
		sudo python -m pip install pylint -y
		sudo apt install clang-format-3.8 -y
		robowareName="roboware.deb"
		wget -O ${robowareName} -c ${robowareLink}
		sudo dpkg -i ${robowareName}
		sudo apt-get -f install -y
		;;
		5)		
		anacondaName="Anaconda3-5.3.1-Linux-x86_64.sh"
		wget -O ${anacondaName} -c ${anacondaLink}
		chmod +x ${anacondaName}
		./${anacondaName}
		;;
		6)
		sudo snap install pycharm-community --classic
		;;
		7)
		mendeleyName="mendeley.deb"
		wget -O ${mendeleyName} -c ${mendeleyLink}
		sudo dpkg -i ${mendeleyName}
		sudo apt-get -f install -y
		;;
		8)
		virtualboxName="virtualbox.deb"
		wget -O ${virtualboxName} -c ${virtualboxLink}
		sudo dpkg -i ${virtualboxName}
		sudo apt-get -f install -y
		;;
		9)
		echo "Null"
		;;
		10)
		echo "Null"
		;;		
		11)
		echo "Null"
		;;		
		12)
		echo "Null"
		;;		
		13)
		echo "参考链接：https://pytorch.org/
		"
		# TODO：分为conda和pip两种，其中用pip安装需区分python版本，和cuda版本也有关系，但安装方便，这个之后可以用脚本写
		;;		
		14)
		QGCName="QGC.AppImage"
		wget -O ${QGCName} -c ${QGCLink}
		sudo chmod +x ${QGCName}
		./${QGCName}
		# sudo dpkg -i ${vscodeName}
		;;
		0)
		echo "退出安装系统软件"
		exit
		;;
		*)
		echo "请输入正确数字 [0-10]"
		;;
	esac
	sudo chmod 777 ${package_path} -R
	#clear
done
