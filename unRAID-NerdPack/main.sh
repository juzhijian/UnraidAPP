#!/bin/sh

#====获取仓库名====
APPNAME=$1
echo "仓库名称=${APPNAME}"
#=================

#====获取版本号====
version_string=$(nl /github/workspace/${APPNAME}/plugin/NerdPack.plg | sed -n '6p')
echo ${version_string}
echo ${version_string:27:10}
version=${version_string:27:10}
#=================

echo 运行替换程序成功

#=====设置git=====
git config --global user.name "juzhijian"
git config --global user.email "princergx@live.com"
#=================

#=====替换链接====
echo 开始替换V${version}

mkdir -p "/tmp/GitHub/${APPNAME}/source/NerdPack/"

cp /github/workspace/${APPNAME}/archive/NerdPack-${version}-x86_64-1.txz /tmp/GitHub/${APPNAME}/source/NerdPack/  -R -v -p

cd /tmp/GitHub/${APPNAME}/source/NerdPack/

tar xJvf NerdPack-${version}-x86_64-1.txz

rm -rf NerdPack-${version}-x86_64-1.txz

#=============替换内容

#unRAID-NerdPack
NAME="unRAID-NerdPack"
AUTHOR="dmacias72"
echo "替换 ${AUTHOR} 的 ${NAME}"
grep -rl "https://raw.githubusercontent.com/${AUTHOR}/${NAME}/master/" ./ | xargs sed -i "s/https:\/\/raw.githubusercontent.com\/${AUTHOR}\/${NAME}\/master\//https:\/\/gitcode.net\/juzhijian\/${NAME}\/-\/raw\/master\//g"
#grep -rl "https://raw.github.com/${AUTHOR}/${NAME}/master/" ./ | xargs sed -i "s/https:\/\/raw.github.com\/${AUTHOR}\/${NAME}\/master\//https:\/\/gitcode.net\/juzhijian\/${NAME}\/-\/raw\/master\//g"
#grep -rl "https://github.com/${AUTHOR}/${NAME}/raw/master/" ./ | xargs sed -i "s/https:\/\/github.com\/${AUTHOR}\/${NAME}\/raw\/master\//https:\/\/gitcode.net\/juzhijian\/${NAME}\/-\/raw\/master\//g"

cd /tmp/GitHub/${APPNAME}/source/NerdPack/usr/local/emhttp/plugins/NerdPack/scripts
rm -f packagemanager
wget https://raw.githubusercontent.com/juzhijian/UnraidAPP/main/unRAID-NerdPack/packagemanager

#https://gitcode.net/api/v4/projects/238302/repository/tree?path=packages/6.11
#https://api.github.com/repos/dmacias72/unRAID-NerdPack/contents/packages/6.1

cp /tmp/GitHub/${APPNAME}/source/NerdPack/* /github/workspace/${APPNAME}/source/NerdPack/ -R -v -p -f

#===============替换结束

#=====更新plg=====
cd /github/workspace/${APPNAME}/plugin

sed -i "8c <!ENTITY gitURL    \"https://gitcode.net/juzhijian/unRAID-&name;/-/raw/master\">" NerdPack.plg

echo 替换结束
#=================


#=====开始打包====
echo 开始打包

cd /tmp/GitHub/${APPNAME}/source/NerdPack/

chmod 0755 -R .

echo "7zip压缩"
7z a -ttar -r NerdPack-${version}-x86_64-1.tar usr/
7z a -txz -r NerdPack-${version}-x86_64-1.txz NerdPack-${version}-x86_64-1.tar
echo "7zip压缩完成"

cp /tmp/GitHub/${APPNAME}/source/NerdPack/NerdPack-${version}-x86_64-1.txz /github/workspace/${APPNAME}/archive/ -R -v -p -f

cd /github/workspace/${APPNAME}/archive/

rm -f NerdPack-${version}-x86_64-1.md5

find NerdPack-${version}-x86_64-1.txz -type f -exec md5sum {} + >/github/workspace/${APPNAME}/archive/NerdPack-${version}-x86_64-1.md5

find . -type f -exec md5sum {} + >/tmp/ca.md5

echo 打包结束
#=================