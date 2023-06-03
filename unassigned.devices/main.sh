#!/bin/sh

#====获取仓库名====
APPNAME=$1
echo "仓库名称=${APPNAME}"
#=================

#====获取版本号====
version_string=$(nl /github/workspace/${APPNAME}/${APPNAME}.plg | sed -n '5p')

echo 获取 \" 号左边的所有字符
version_string=${version_string#*\"}
echo 结果为：${version_string}

echo 获取 \" 号右边的所有字符
version_string=${version_string%\"*}
echo 结果为：${version_string}

version=${version_string}
#=================


echo 运行替换程序成功

#=====设置git=====
git config --global user.name "juzhijian"
git config --global user.email "princergx@live.com"
#=================



#=====更新plg====
cd /github/workspace/${APPNAME}

sed -i "7,7c <!ENTITY gitURL		\"https://gitcode.net/juzhijian/&name;/-/raw/master\">" ${APPNAME}.plg
sed -i "7,7c <!ENTITY gitURL		"https://gitcode.net/juzhijian/unassigned.devices/-/raw/master">" unassigned.devices-plus.plg
sed -i "7,7c <!ENTITY gitURL		"https://gitcode.net/juzhijian/unassigned.devices/-/raw/master">" unassigned.devices.preclear.plg

cd /github/workspace/${APPNAME}/
sed -i "s/raw.githubusercontent.com\/dlandon/gitcode.net\/juzhijian/g" $(grep "raw.githubusercontent.com\/dlandon" -rl ./)
sed -i "s/\/master\//\/-\/raw\/master\//g" $(grep "\/master\/" -rl ./)

echo 替换结束

#=================
