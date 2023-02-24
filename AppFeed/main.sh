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

echo 测试开始搜索文件
find / -name "applicationFeed.json"

echo 显示当前路径
pwd

echo 显示文件目录
ls -a

echo 测试开始搜索文件结束

echo 开始替换
#ca.update.applications
sed -i "s/https:\/\/raw.githubusercontent.com\/Squidly271\/ca.update.applications\/master\//https:\/\/juzhijian.coding.net\/p\/unraidapp\/d\/ca.update.applications\/git\/raw\/master\//g" $(grep "https://raw.githubusercontent.com/Squidly271/ca.update.applications/master/" -rl ./)
#plugin-repository
sed -i "s/https:\/\/raw.githubusercontent.com\/Squidly271\/plugin-repository\/master\//https:\/\/juzhijian.coding.net\/p\/unraidapp\/d\/plugin-repository\/git\/raw\/master\//g" $(grep "https://raw.githubusercontent.com/Squidly271/plugin-repository/master/" -rl ./)
#community.applications
sed -i "s/https:\/\/github.com\/Squidly271\/community.applications\/raw\/master\//https:\/\/juzhijian.coding.net\/p\/unraidapp\/d\/community.applications\/git\/raw\/master\//g" $(grep "https://github.com/Squidly271/community.applications/raw/master/" -rl ./)
#fix.common.problems
sed -i "s/https:\/\/raw.githubusercontent.com\/Squidly271\/fix.common.problems\/master\//https:\/\/juzhijian.coding.net\/p\/unraidapp\/d\/fix.common.problems\/git\/raw\/master\//g" $(grep "https://raw.githubusercontent.com/Squidly271/fix.common.problems/master/" -rl ./)
#dynamix
sed -i "s/https:\/\/raw.githubusercontent.com\/bergware\/dynamix\/master\//https:\/\/juzhijian.coding.net\/p\/unraidapp\/d\/dynamix\/git\/raw\/master\//g" $(grep "https://raw.githubusercontent.com/bergware/dynamix/master/" -rl ./)
sed -i "s/https:\/\/raw.github.com\/bergware\/dynamix\/master\//https:\/\/juzhijian.coding.net\/p\/unraidapp\/d\/dynamix\/git\/raw\/master\//g" $(grep "https://raw.github.com/bergware/dynamix/master/" -rl ./)


# 创建新分支 "latest_branch" 并转到该分支
# git checkout 命令为在当前分支上创建新分支(并转到该分支)
# git checkout --orphan 命令为从空白处创建新分支(并转到该分支)
git checkout --orphan latest_branch

# 添加所有文件(当前最新状态)到暂存区
git add -A

# 将暂存区提交到新纪录(latest_branch分支)
# "commit message"为新纪录的名称
git commit -am "commit message"

# 删除主分支
git branch -D master

# 将latest_branch(当前)分支重命名为master(主分支)
git branch -m master

echo 替换结束
