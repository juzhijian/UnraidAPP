#!/bin/sh

#====获取参数====
APPNAME=$1
#=================

echo 运行替换程序成功

#=====设置git=====
git config --global user.name "聚指尖"
git config --global user.email "admin@juzhijian.com"
#=================

echo 测试开始搜索文件
find / -name "applicationFeed.json"
pwd
ls

echo 开始替换

sed -i "s/https:\/\/raw.githubusercontent.com\/Squidly271\/ca.update.applications\/master\//https:\/\/juzhijian.coding.net\/p\/unraidapp\/d\/ca.update.applications\/git\/raw\/master\//g" $(grep "https://raw.githubusercontent.com/Squidly271/ca.update.applications/master/" -rl ./)

sed -i "s/https:\/\/raw.githubusercontent.com\/Squidly271\/plugin-repository\/master\//https:\/\/juzhijian.coding.net\/p\/unraidapp\/d\/plugin-repository\/git\/raw\/master\//g" $(grep "https://raw.githubusercontent.com/Squidly271/plugin-repository/master/" -rl ./)

echo 替换结束
