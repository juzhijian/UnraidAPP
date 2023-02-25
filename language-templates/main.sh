#!/bin/sh

#====获取仓库名====
APPNAME=$1
echo "仓库名称=${APPNAME}"
#=================

echo 运行替换程序成功

#=====设置git=====
git config --global user.name "juzhijian"
git config --global user.email "princergx@live.com"
#=================


#=============替换内容

#language-templates
NAME="language-templates"
AUTHOR="unraid"
echo "替换 ${AUTHOR} 的 ${NAME}"
grep -rl "https://raw.githubusercontent.com/${AUTHOR}/${NAME}/master/" ./ | xargs sed -i "s/https:\/\/raw.githubusercontent.com\/${AUTHOR}\/${NAME}\/master\//https:\/\/gitcode.net\/juzhijian\/${NAME}\/-\/raw\/master\//g"
#grep -rl "https://raw.github.com/${AUTHOR}/${NAME}/master/" ./ | xargs sed -i "s/https:\/\/raw.github.com\/${AUTHOR}\/${NAME}\/master\//https:\/\/gitcode.net\/juzhijian\/${NAME}\/-\/raw\/master\//g"
#grep -rl "https://github.com/${AUTHOR}/${NAME}/raw/master/" ./ | xargs sed -i "s/https:\/\/github.com\/${AUTHOR}\/${NAME}\/raw\/master\//https:\/\/gitcode.net\/juzhijian\/${NAME}\/-\/raw\/master\//g"

grep -rl "https://github.com/unraid/lang-zh_CN/archive/master.zip" ./ | xargs sed -i "s/https:\/\/github.com\/unraid\/lang-zh_CN\/archive\/master.zip/https:\/\/gitcode.net\/juzhijian\/lang-zh_cn\/-\/archive\/master\/lang-zh_cn-master.zip/g"

#===============替换


echo 替换结束
#=================
