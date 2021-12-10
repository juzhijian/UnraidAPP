#!/bin/sh

#====获取参数====
APPNAME=$1
echo "程序名称=${APPNAME}"
#=================

#====获取版本号====
version_string=$(nl /github/workspace/${APPNAME}/plugins/${APPNAME}.plg | sed -n '5p')
echo ${version_string}
echo ${version_string:27:10}
version=${version_string:27:10}
#=================

echo 运行替换程序成功

#=====设置git=====
git config --global user.name "聚指尖"
git config --global user.email "admin@juzhijian.com"
#=================

#=====替换链接====
echo 开始替换V${version}

mkdir -p "/tmp/GitHub/${APPNAME}/source/${APPNAME}/usr/local/emhttp/plugins/${APPNAME}/"
cd archive
tar xJvf ${APPNAME}-${version}-x86_64-1.txz
cp /github/workspace/${APPNAME}/archive/usr/local/emhttp/plugins/${APPNAME}/* /tmp/GitHub/${APPNAME}/source/${APPNAME}/usr/local/emhttp/plugins/${APPNAME} -R -v -p
rm -rf usr
cd /tmp/GitHub/${APPNAME}/source/${APPNAME}/usr/local/emhttp/plugins/${APPNAME}

sed -i "s/https:\/\/github.com\/Squidly271\/plugin-repository\/raw\/master\//https:\/\/juzhijian.coding.net\/p\/unraidapp\/d\/plugin-repository\/git\/raw\/master\//g" $(grep "https://github.com/Squidly271/plugin-repository/raw/master/" -rl ./)

sed -i "s/https:\/\/raw.githubusercontent.com\/Squidly271\/Community-Applications-Moderators\/master\//https:\/\/juzhijian.coding.net\/p\/unraidapp\/d\/Community-Applications-Moderators\/git\/raw\/master\//g" $(grep "https://raw.githubusercontent.com/Squidly271/Community-Applications-Moderators/master/" -rl ./)

sed -i "s/https:\/\/raw.githubusercontent.com\/Squidly271\/AppFeed\/master\//https:\/\/juzhijian.coding.net\/p\/unraidapp\/d\/AppFeed\/git\/raw\/master\//g" $(grep "https://raw.githubusercontent.com/Squidly271/AppFeed/master/" -rl ./)

cp /tmp/GitHub/${APPNAME}/source/${APPNAME}/usr/local/emhttp/plugins/${APPNAME}/* /github/workspace/${APPNAME}/source/${APPNAME}/usr/local/emhttp/plugins/${APPNAME} -R -v -p -f

cd /github/workspace/${APPNAME}/plugins

sed -i "9,10c <!ENTITY github    \"p/unraidapp/d/${APPNAME}/git/raw\">\n<!ENTITY pluginURL \"https://juzhijian.coding.net/&github;/master/plugins/&name;.plg\">" ${APPNAME}.plg

sed -i "s/raw.githubusercontent.com/juzhijian.coding.net/g" $(grep "raw.githubusercontent.com" -rl ./)

echo 替换结束
#=================


#=====开始打包====
echo 开始打包

cd /tmp/GitHub/${APPNAME}/source/${APPNAME}/

chmod 0755 -R .

echo "7zip压缩"
7za a -ttar -r ${APPNAME}-${version}-x86_64-1.tar usr/
7za a -txz -r ${APPNAME}-${version}-x86_64-1.txz ${APPNAME}-${version}-x86_64-1.tar
echo "7zip压缩完成"

cp /tmp/GitHub/${APPNAME}/source/${APPNAME}/${APPNAME}-${version}-x86_64-1.txz /github/workspace/${APPNAME}/archive/ -R -v -p -f

md5_data=$(md5sum /tmp/GitHub/${APPNAME}/source/${APPNAME}/${APPNAME}-${version}-x86_64-1.txz | cut -d ' ' -f1)

echo "md5_data = ${md5_data}"

cd /github/workspace/${APPNAME}/plugins
sed -i "6c <!ENTITY md5       "\"${md5_data}\"">" ${APPNAME}.plg

echo 打包结束
#=================