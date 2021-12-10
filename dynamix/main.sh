#!/bin/sh

#====获取参数====
APPNAME=$1
echo "程序名称=${APPNAME}"
#=================


echo 运行替换程序成功

#=====设置git=====
git config --global user.name "聚指尖"
git config --global user.email "admin@juzhijian.com"
#=================

#=====替换链接====
echo 开始替换

cd /github/workspace/${APPNAME}/unRAIDv6

sed -i "s/https:\/\/raw.githubusercontent.com\/bergware\/dynamix\/master\//https:\/\/juzhijian.coding.net\/p\/unraidapp\/d\/dynamix\/git\/raw\/master\//g" $(grep "https://raw.githubusercontent.com/bergware/dynamix/master/" -rl ./)

echo 替换结束
#=================

#===替换cache.dirs====
releaseTag_string="<!ENTITY releaseTag \"cache_dirs_2.2.7-2\">"
echo ${releaseTag_string}
echo ${releaseTag_string#*\"}

releaseTag_string=${releaseTag_string#*\"}
echo ${releaseTag_string}
echo ${releaseTag_string%\"*}

releaseTag=${releaseTag_string%\"*}
echo "最后"
echo ${releaseTag}
#=====================