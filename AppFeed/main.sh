#!/bin/sh
###
 # @Author: your name
 # @Date: 2021-12-09 20:43:13
 # @LastEditTime: 2021-12-09 20:45:21
 # @LastEditors: your name
 # @Description: 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 # @FilePath: \SourceTree\Unraid\UnraidAPP\AppFeed\main.sh
### 
echo 运行替换程序成功

git config --global user.name "聚指尖"
git config --global user.email "admin@juzhijian.com"

echo 测试开始搜索文件
find / -name "applicationFeed.json"
pwd
echo 开始替换
sed -i  "s/https:\/\/raw.githubusercontent.com\/Squidly271\/ca.update.applications\/master\//https:\/\/juzhijian.coding.net\/p\/unraidapp\/d\/ca.update.applications\/git\/raw\/master\//g"  `grep "https://raw.githubusercontent.com/Squidly271/ca.update.applications/master/" -rl ./ -R --exclude-dir=.git`



echo 替换结束
