#!/bin/sh

#====获取参数====
APPNAME=$1
echo "仓库名称=${APPNAME}"
#=================

#====获取版本号====
version_string=$(nl /github/workspace/${APPNAME}/plugins/${APPNAME}.plg | sed -n '5p')
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

mkdir -p "/tmp/GitHub/${APPNAME}/source/${APPNAME}/usr/local/emhttp/plugins/${APPNAME}/"
cd archive
tar xJvf ${APPNAME}-${version}-x86_64-1.txz
cp /github/workspace/${APPNAME}/archive/usr/local/emhttp/plugins/${APPNAME}/* /tmp/GitHub/${APPNAME}/source/${APPNAME}/usr/local/emhttp/plugins/${APPNAME} -R -v -p
rm -rf usr
cd /tmp/GitHub/${APPNAME}/source/${APPNAME}/usr/local/emhttp/plugins/${APPNAME}

sed -i "s/https:\/\/github.com\/Squidly271\/plugin-repository\/raw\/master\//https:\/\/gitcode.net\/juzhijian\/plugin-repository\/-\/raw\/master\//g" $(grep "https://github.com/Squidly271/plugin-repository/raw/master/" -rl ./)

sed -i "s/https:\/\/raw.githubusercontent.com\/Squidly271\/Community-Applications-Moderators\/master\//https:\/\/gitcode.net\/juzhijian\/community-applications-moderators\/-\/raw\/master\//g" $(grep "https://raw.githubusercontent.com/Squidly271/Community-Applications-Moderators/master/" -rl ./)

sed -i "s/https:\/\/raw.githubusercontent.com\/Squidly271\/AppFeed\/master\//https:\/\/gitcode.net\/juzhijian\/appfeed\/-\/raw\/master\//g" $(grep "https://raw.githubusercontent.com/Squidly271/AppFeed/master/" -rl ./)

cp /tmp/GitHub/${APPNAME}/source/${APPNAME}/usr/local/emhttp/plugins/${APPNAME}/* /github/workspace/${APPNAME}/source/${APPNAME}/usr/local/emhttp/plugins/${APPNAME} -R -v -p -f

#=====更新plg====
cd /github/workspace/${APPNAME}/plugins

sed -i "9,10c <!ENTITY github    \"juzhijian/${APPNAME}/-/raw\">\n<!ENTITY pluginURL \"https://gitcode.net/&github;/master/plugins/&name;.plg\">" ${APPNAME}.plg

sed -i "s/raw.githubusercontent.com/gitcode.net/g" $(grep "raw.githubusercontent.com" -rl ./)

echo 替换结束
#=================


#=====开始打包====
echo 开始打包

cd /tmp/GitHub/${APPNAME}/source/${APPNAME}/

chmod 0755 -R .

echo "7zip压缩"
7z a -ttar -r ${APPNAME}-${version}-x86_64-1.tar usr/
7z a -txz -r ${APPNAME}-${version}-x86_64-1.txz ${APPNAME}-${version}-x86_64-1.tar
echo "7zip压缩完成"

cp /tmp/GitHub/${APPNAME}/source/${APPNAME}/${APPNAME}-${version}-x86_64-1.txz /github/workspace/${APPNAME}/archive/ -R -v -p -f

md5_data=$(md5sum /tmp/GitHub/${APPNAME}/source/${APPNAME}/${APPNAME}-${version}-x86_64-1.txz | cut -d ' ' -f1)

echo "md5_data = ${md5_data}"

cd /github/workspace/${APPNAME}/plugins
sed -i "6c <!ENTITY md5       "\"${md5_data}\"">" ${APPNAME}.plg

echo 打包结束
#=================