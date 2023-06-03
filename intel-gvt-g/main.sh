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
sed -i "10,10c <!ENTITY pluginURL "https://gitcode.net/juzhijian/&name;/-/raw/master/&name;.plg">"

cd /github/workspace/${APPNAME}/
sed -i "s/raw.githubusercontent.com\/ich777/gitcode.net\/juzhijian/g" $(grep "raw.githubusercontent.com\/ich777" -rl ./)
sed -i "s/\/master\//\/-\/raw\/master\//g" $(grep "\/master\/" -rl ./)

echo 替换结束

#=================
