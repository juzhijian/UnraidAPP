#!/bin/sh

#====获取仓库名====
APPNAME=$1
echo "仓库名称=${APPNAME}"
#=================

#====获取版本号====
version_string=$(nl /github/workspace/${APPNAME}/vmbackup.plg | sed -n '6p')
echo ${version_string}
echo ${version_string:27:10}
version=${version_string:27:10}
#=================

echo 运行替换程序成功

#=====设置git=====
git config --global user.name "juzhijian"
git config --global user.email "princergx@live.com"
#=================

#=====更新plg====
cd /github/workspace/${APPNAME}/

sed -i "10,11c <!ENTITY github \"juzhijian/${APPNAME}/-/raw\">\n<!ENTITY pluginURL \"https://gitcode.net/&github;/master/&plugin;.plg\">" vmbackup.plg

sed -i "s/raw.githubusercontent.com\//jtok/gitcode.net\//juzhijian/g" $(grep "raw.githubusercontent.com\//jtok" -rl ./)

echo 替换结束
#=================
