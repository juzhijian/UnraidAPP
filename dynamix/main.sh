#!/bin/sh

#====获取参数====
APPNAME=$1
echo "仓库名称=${APPNAME}"
#=================


echo 运行替换程序成功

#=====设置git=====
git config --global user.name "juzhijian"
git config --global user.email "princergx@live.com"
#=================

#=====替换链接====
echo 开始替换

cd /github/workspace/${APPNAME}/unRAIDv6

rm -rf dynamix.cache.dirs-aberg.plg

wegt https://raw.githubusercontent.com/arberg/dynamix/master/unRAIDv6/dynamix.cache.dirs-aberg.plg

sed -i "s/https:\/\/raw.githubusercontent.com\/bergware\/dynamix\/master\//https:\/\/juzhijian.coding.net\/p\/unraidapp\/d\/dynamix\/git\/raw\/master\//g" $(grep "https://raw.githubusercontent.com/bergware/dynamix/master/" -rl ./)

sed -i "s/https:\/\/github.com\/arberg\/dynamix\/releases\/download\/\&releaseTag;\/\&name;.txz/https:\/\/juzhijian.coding.net\/p\/unraidapp\/d\/dynamix\/git\/raw\/master\/archive\/\&name;-aberg.txz/g" $(grep "https://github.com/arberg/dynamix/releases/download/&releaseTag;/&name;.txz" -rl ./)

sed -i "s/https:\/\/raw.githubusercontent.com\/arberg\/dynamix\/master\//https:\/\/juzhijian.coding.net\/p\/unraidapp\/d\/dynamix\/git\/raw\/master\//g" $(grep "https://raw.githubusercontent.com/arberg/dynamix/master/" -rl ./)

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

cd /github/workspace/${APPNAME}/archive
wget -O dynamix.cache.dirs-aberg.txz https://github.com/arberg/dynamix/releases/download/${releaseTag}/dynamix.cache.dirs.txz

#=====================