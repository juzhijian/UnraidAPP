#!/bin/sh

version=2021.12.08

echo 运行替换程序成功

git config --global user.name "聚指尖"
git config --global user.email "admin@juzhijian.com"

echo 开始替换V$version

mkdir -p "/tmp/GitHub/community.applications/source/community.applications/"
cd archive
ls
tar xJvf community.applications-${version}-x86_64-1.txz
#cd /tmp/GitHub/community.applications/source/community.applications/
ls

#cp /github/workspace/community.applications/source/community.applications/usr/local/emhttp/plugins/community.applications/* /tmp/GitHub/community.applications/source/community.applications/usr/local/emhttp/plugins/community.applications -R -v -p
#cd /tmp/GitHub/community.applications/source/community.applications/usr/local/emhttp/plugins/community.applications
#rm -f  ca.md5
#find . -type f -exec md5sum {} + > /tmp/ca.md5
#mv /tmp/ca.md5 ca.md5


echo 替换结束

echo 开始打包

echo 打包结束
