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

echo 开始替换V${version}

mkdir -p "/tmp/GitHub/${APPNAME}/source/preclear.disk/usr/local/emhttp/plugins/preclear.disk/"

cd archive
tar xJvf preclear.disk-${version}.txz

cp /github/workspace/${APPNAME}/archive/usr/local/emhttp/plugins/preclear.disk/* /tmp/GitHub/${APPNAME}/source/preclear.disk/usr/local/emhttp/plugins/preclear.disk -R -v -p
rm -rf usr

#=====更新plg====
cd /github/workspace/${APPNAME}/plugins

#sed -i "8,8c <!ENTITY branch     \"-/raw/master\">" vmbackup.plg

#sed -i "11,11c <!ENTITY gitURL     \"https://gitcode.net/juzhijian/unraid.&name;/&branch;\">" vmbackup.plg


sed -i "9,9c <!ENTITY gitURL    \"https://gitcode.net/juzhijian/&repo;/-/raw/master\">" preclear.disk.plg
sed -i "8,8c <!ENTITY gitURL    \"https://gitcode.net/juzhijian/&repo;/-/raw/master\">" statistics.sender.plg

cd /tmp/GitHub/${APPNAME}/source/preclear.disk/usr/local/emhttp/plugins/preclear.disk
sed -i "s/raw.githubusercontent.com\/gfjardim/gitcode.net\/juzhijian/g" $(grep "raw.githubusercontent.com\/gfjardim" -rl ./)
sed -i "s/\/master\//\/-\/raw\/master\//g" $(grep "\/master\/" -rl ./)

echo 替换结束


cp /tmp/GitHub/${APPNAME}/source/preclear.disk/usr/local/emhttp/plugins/preclear.disk/* /github/workspace/${APPNAME}/source/preclear.disk -R -v -p -f

#=================

#=====开始打包====
echo “开始打包”
cd /tmp/GitHub/${APPNAME}/source/preclear.disk/

chmod 0755 -R .

echo "7zip压缩"
7z a -ttar -r preclear.disk-${version}.tar usr/
7z a -txz -r preclear.disk-${version}.txz preclear.disk-${version}.tar

cp /tmp/GitHub/${APPNAME}/source/preclear.disk/preclear.disk-${version}.txz /github/workspace/${APPNAME}/archive/ -R -v -p -f

cd /github/workspace/${APPNAME}/archive/

rm -f preclear.disk-${version}.md5

find preclear.disk-${version}.txz -type f -exec md5sum {} + >/github/workspace/${APPNAME}/archive/preclear.disk-${version}.md5

find . -type f -exec md5sum {} + >/tmp/ca.md5


echo 打包结束
#=================
