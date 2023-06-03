#!/bin/sh

#====获取仓库名====
APPNAME=$1
echo "仓库名称=${APPNAME}"
#=================

#====获取版本号====
version_string=$(nl /github/workspace/${APPNAME}/plugins/preclear.disk.plg | sed -n '7p')

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
cd /github/workspace/${APPNAME}/plugins

#sed -i "8,8c <!ENTITY branch     \"-/raw/master\">" vmbackup.plg

#sed -i "11,11c <!ENTITY gitURL     \"https://gitcode.net/juzhijian/unraid.&name;/&branch;\">" vmbackup.plg


sed -i "9,9c <!ENTITY gitURL    \"https://gitcode.net/juzhijian/&repo;/-/raw/master\">" preclear.disk.plg
sed -i "8,8c <!ENTITY gitURL    \"https://gitcode.net/juzhijian/&repo;/-/raw/master\">" statistics.sender.plg

cd /github/workspace/${APPNAME}/
sed -i "s/raw.githubusercontent.com\/gfjardim/gitcode.net\/juzhijian/g" $(grep "raw.githubusercontent.com\/gfjardim" -rl ./)
sed -i "s/\/master\//\/-\/raw\/master\//g" $(grep "\/master\/" -rl ./)

echo 替换结束

#=================
