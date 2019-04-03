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

ChromeLink="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
netMusicLink="http://d1.music.126.net/dmusic/netease-cloud-music_1.1.0_amd64_ubuntu.deb"
wpsLink="http://kdl.cc.ksosoft.com/wps-community/download/6757/wps-office_10.1.0.6757_amd64.deb"
foxitLink="http://cdn01.foxitsoftware.com/pub/foxit/reader/desktop/linux/2.x/2.4/en_us/FoxitReader.enu.setup.2.4.4.0911.x64.run.tar.gz"

vim_setting(){
#LASTLINE=$(tail -1 /etc/vim/vimrc)
#if [ "${LASTLINE}" !=  '"add vim setting end' ];then

if [ `grep -c 'add vim setting end' /etc/vim/vimrc` -eq '0' ];then
	echo "添加vim个性化设置到/etc/vim/vimrc"
	FILE=${setting_path}/vim_setting.txt
	k=1
	while read -r line;do	
		sudo echo ${line} >> /etc/vim/vimrc
		((k++))
	done < ${FILE} 
fi
}
while :
do
	echo -e " 
————————————
${Green_font_prefix} 1.${Font_color_suffix} Chromium浏览器
${Green_font_prefix} 2.${Font_color_suffix} 网易云音乐
${Green_font_prefix} 3.${Font_color_suffix} VIM+自动配置
${Green_font_prefix} 4.${Font_color_suffix} Typora
${Green_font_prefix} 5.${Font_color_suffix} 福昕阅读器
${Green_font_prefix} 6.${Font_color_suffix} Calibre
${Green_font_prefix} 7.${Font_color_suffix} WPS Office 
————————————
${Green_font_prefix} 0.${Font_color_suffix} 退出工具安装
————————————" && echo
	echo
	read -e -p " 请输入数字 [0-10]:" num
	case "$num" in
		1)
		sudo add-apt-repository ppa:a-v-shkop/chromium -y
		sudo apt-fast update
		sudo apt-fast install chromium-browser -y
		sudo add-apt-repository -r ppa:a-v-shkop/chromium -y  # have great effect for apt update, but remove it may cause unable to update chromium
		######
		#chromeName="chrome.deb"
		#sudo wget -O ${chromeName} -c ${ChromeLink}
		#sudo dpkg -i ${chromeName}
		#sudo wget http://www.linuxidc.com/files/repo/google-chrome.list -P /etc/apt/sources.list.d/
		#wget -q -O - https://dl.google.com/linux/linux_signing_key.pub  | sudo apt-fast-key add -
		#sudo apt-fast update
		#sudo apt-fast install google-chrome-stable -y
		######
		;;
		2)
		netMusicName="netMusic.deb"
		wget -O ${netMusicName} -c ${netMusicLink}
		sudo apt-fast install vlc
		sudo dpkg -i ${netMusicName}
		sudo apt-fast -f -y install # install depend
		;;
		3)
		sudo apt-fast install -y vim
		vim_setting
		;;
		4)
		# sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys BA300B7755AFCFAE
		wget -qO - https://typora.io/linux/public-key.asc | sudo apt-key add -
		sudo add-apt-repository 'deb https://typora.io linux/' -y
		# sudo add-apt-repository 'deb https://typora.io/linux ./'
		sudo apt-fast update
		sudo apt-fast install typora  -y
		;;
		5) 
		foxitName="foxit.run"
		wget -O ${foxitName}.tar.gz -c ${foxitLink}
		tar xvzf ${foxitName}.tar.gz -O > ${foxitName}
		chmod +x ${foxitName}
		sudo ./${foxitName}
		;;
		6)
		# sudo -v && wget --no-check-certificate -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sudo sh / dev / stdin
		sudo -v && wget -nv -O- https://download.calibre-ebook.com/linux-installer.py | sudo python -c "import sys; main=lambda:sys.stderr.write('Download failed\n'); exec(sys.stdin.read()); main()"
		;;
		7)
		wpsName="wps.deb"
		wget -O ${wpsName} -c ${wpsLink}
		sudo dpkg -i ${wpsName}
		;;
		8)
		sudo add-apt-repository ppa:notepadqq-team/notepadqq -y
		sudo apt-fast update && sudo apt-fast install notepadqq -y
		;;
		0)
		echo "退出安装浏览软件"
		exit
		;;
		9)
		echo "退出安装浏览软件"
		exit
		;;
		*)
		echo "请输入正确数字 [0-10]"
		;;
	esac
	sudo chmod 777 ${package_path} -R
	clear
done
