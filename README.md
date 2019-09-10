# 一键安装脚本

[TOC]

## 简介

本脚本可实现使用shell在Ubuntu16及18系统一键快速安装常用软件.  ~~（包括讨厌的拼音输入法和nVidia驱动）~~

![Interface](./image/Interface.png)



## TODO:

- Translate to English
- 将实验室内部使用版本进一步整理



## 使用说明

**为了更好的观看本文档,可安装脚本中[2]->[4]的Typora软件打开本文档.**

首次执行需为安装脚本添加可运行权限：

```
chmod +x ./Install.sh
```

之后只需在安装脚本目录输入:

```bash
./Install.sh
```

输入管理员密码后便可启动脚本,**注意此处使用`sudo ./Install.sh`启动脚本会对安装文件的读取权限产生影响造成如ROS，anaconda无法正常使用等问题。**

使用目前带"#"的项目暂不可使用,使用时出现问题可鼠标滚轮向上翻页查看错误信息进行排查。

首次安装需选择**[10]** ,更新软件源并与安装安装器,~~apt-fast安装过程中的设置依次选择：apt，16，Yes~~

如想重新更新软件源：

输入以下指令删除软件源文件重新选[10]即可：

```
sudo rm /etc/apt/sources.list
```

软件源测速结果如图:

![source_speedtest](./image/source_speedtest.png)

可根据实际情况修改setting_file文件夹中source_list.txt选择需要添加的软件源

除Shadowsocks-qt5及部分美化插件外,其他软件在开始菜单处打开

## 软件清单

### 必备软件

1. 搜狗输入法
2. Google输入法
3. lantern
4. Shadowsocks-qt5
5. NVIDIA驱动

### 文件浏览软件

1. Chromium浏览器
2. 网易云音乐
3. VIM+自动配置
4. Typora
5. 福昕阅读器
6. Calibre
7. WPS Office 

### 科研工具

1. QT 5.10.0
2. VS code
3. ROS kinetic
4. Roboware Studio
5. Anaconda
6. Pycharm
7. Mendeley
8. virtualbox虚拟机

### 常用工具

1. 有道词典【翻译软件】
2. Git【版本管理】
3. Teamviewer【远程控制】
4. nomachine【远程控制】
5. flameshot【截图软件】
6. Seafile客户端【备份软件】
7. Uget+aria2c【下载器】
8. wewechat【微信客户端】
9. gdebi【deb安装器】
10. Synergy Pro【多电脑共用一套鼠键】
11. 【利用translate-shell做的轻量翻译小工具】 **new~！**

### 系统美化软件

1. conky【边栏信息】
2. Docky【底栏】
3. Unity Tweak Tool【系统主题设置】
4. indicator-multiload 【状态栏显示系统信息】
5. cairo-dock【底栏】【推荐】
6. flatabulous-theme+MacUbuntu【主题】
7. gnome-tweak-tool【系统主题设置】

## 安装部分软件设置说明

**搜狗输入法**:安装完后需重启,在系统设置中选择启用.

**Shadowsocks-qt5**:安装后软件将在后台运行并设置开机启动,如需查看软件界面需找到安装包目录双击打开软件或重启电脑查看.若需要在终端窗口使用外网服务器代理访问，可使用`export ALL_PROXY=socks5://127.0.0.1:6666`，输入`curl ip.gs`查看ip信息确认是否代理成功。如在setting_file中存在ss_config.ini则自动添加代理服务器信息,如不存在则需在软件界面自行添加,具体查看之前共享的压缩包资料.部分软件可能使用http协议传输无法代理,可参考:ProxyChains,polipo,Privoxy等使这类软件使用国外服务器,脚本暂不添加这部分内容.

~~NVIDIA驱动:TODO~~

**VIM**:安装过程中已配置代码补全,代码高亮等功能,如需修改,则setting_file中存在vim_setting.txt修改.

**ROS kinetic**:本选项调用install_ros_kinetic.sh脚本,安装并在HOME目录创建了一个catkin_ws.注意kinetic对应Ubuntu16版本系统

**Synergy Pro:** 需在服务器端添加客户端计算机名字，具体看压缩包说明

**flameshot:** 可设置启用将截图贴在桌面功能，可修改系统快捷键实现点击快捷键后截图，具体设置参考网络教程。

**Roboware Studio :** 选择安装后按方向键→选中OK，接受协议后安装

**copytrans：** 读取剪切板内容并发送到translate-shell实现翻译并在通知栏显示翻译结果。安装重启后生效，复制英文，按【Ctrl+1】显示翻译，效果如图：

![Copytrans](./image/Copytrans.png)

## 参考链接

TODO

## 补充

欢迎提交常用软件或反馈遇到的bug,联系方式:Xue.JW@qq.com



