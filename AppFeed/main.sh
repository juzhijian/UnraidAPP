#!/bin/sh
echo 运行替换程序成功
echo 测试开始搜索文件
find / -name "applicationFeed.json"
pwd
echo 开始替换
sed -i  "s/"https://raw.githubusercontent.com/Squidly271/ca.update.applications/master/"/"https://juzhijian.coding.net/p/unraidapp/d/ca.update.applications/git/raw/master/"/g"  `grep "https://juzhijian.coding.net/p/unraidapp/d/ca.update.applications/git/raw/master/" -rl ./ -R --exclude-dir=.git`
echo 运行结束
