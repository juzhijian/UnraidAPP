#!/bin/sh

#====获取仓库名====
APPNAME=$1
echo "仓库名称=${APPNAME}"
#=================

#====获取版本号====
version_string=$(nl /github/workspace/${APPNAME}/plugins/${APPNAME}.plg | sed -n '5p')
#echo ${version_string}
#echo ${version_string:27:10}

#if [[ "${version_string:38:1}" == ">" ]]; then
#    echo "版本为纯数字"
#    version=${version_string:27:10}
#fi

#if [[ "${version_string:38:1}" != ">" ]]; then
#    echo "版本带英文"
#    version=${version_string:27:11}
#fi

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

#=====替换链接====
echo 开始替换V${version}

mkdir -p "/tmp/GitHub/${APPNAME}/source/${APPNAME}/usr/local/emhttp/plugins/${APPNAME}/"

cd archive
tar xJvf ${APPNAME}-${version}-x86_64-1.txz
cp /github/workspace/${APPNAME}/archive/usr/local/emhttp/plugins/${APPNAME}/* /tmp/GitHub/${APPNAME}/source/${APPNAME}/usr/local/emhttp/plugins/${APPNAME} -R -v -p
rm -rf usr
cd /tmp/GitHub/${APPNAME}/source/${APPNAME}/usr/local/emhttp/plugins/${APPNAME}

#=============替换内容
#Community-Applications-Moderators
NAME="Community-Applications-Moderators"
AUTHOR="Squidly271"
echo "替换 ${AUTHOR} 的 ${NAME}"
grep -rl "https://raw.githubusercontent.com/${AUTHOR}/${NAME}/master/" ./ | xargs sed -i "s/https:\/\/raw.githubusercontent.com\/${AUTHOR}\/${NAME}\/master\//https:\/\/gitcode.net\/juzhijian\/${NAME}\/-\/raw\/master\//g"

#AppFeed
NAME="AppFeed"
AUTHOR="Squidly271"
echo "替换 ${AUTHOR} 的 ${NAME}"
grep -rl "https://raw.githubusercontent.com/${AUTHOR}/${NAME}/master/" ./ | xargs sed -i "s/https:\/\/raw.githubusercontent.com\/${AUTHOR}\/${NAME}\/master\//https:\/\/gitcode.net\/juzhijian\/${NAME}\/-\/raw\/master\//g"

#community.applications
NAME="community.applications"
AUTHOR="Squidly271"
echo "替换 ${AUTHOR} 的 ${NAME}"
grep -rl "https://raw.githubusercontent.com/${AUTHOR}/${NAME}/master/" ./ | xargs sed -i "s/https:\/\/raw.githubusercontent.com\/${AUTHOR}\/${NAME}\/master\//https:\/\/gitcode.net\/juzhijian\/${NAME}\/-\/raw\/master\//g"

#CA_notifications
NAME="CA_notifications"
AUTHOR="Squidly271"
echo "替换 ${AUTHOR} 的 ${NAME}"
grep -rl "https://raw.githubusercontent.com/${AUTHOR}/${NAME}/master/" ./ | xargs sed -i "s/https:\/\/raw.githubusercontent.com\/${AUTHOR}\/${NAME}\/master\//https:\/\/gitcode.net\/juzhijian\/${NAME}\/-\/raw\/master\//g"
#grep -rl "https://raw.github.com/${AUTHOR}/${NAME}/master/" ./ | xargs sed -i "s/https:\/\/raw.github.com\/${AUTHOR}\/${NAME}\/master\//https:\/\/gitcode.net\/juzhijian\/${NAME}\/-\/raw\/master\//g"
#grep -rl "https://github.com/${AUTHOR}/${NAME}/raw/master/" ./ | xargs sed -i "s/https:\/\/github.com\/${AUTHOR}\/${NAME}\/raw\/master\//https:\/\/gitcode.net\/juzhijian\/${NAME}\/-\/raw\/master\//g"

#===============替换

rm -f ca.md5
find . -type f -exec md5sum {} + >/tmp/ca.md5
mv /tmp/ca.md5 ca.md5

cp /tmp/GitHub/${APPNAME}/source/${APPNAME}/usr/local/emhttp/plugins/${APPNAME}/* /github/workspace/${APPNAME}/source/${APPNAME}/usr/local/emhttp/plugins/${APPNAME} -R -v -p -f

#=====更新plg====
cd /github/workspace/${APPNAME}/plugins

sed -i "9,10c <!ENTITY github    \"juzhijian/${APPNAME}/-/raw\">\n<!ENTITY pluginURL \"https://gitcode.net/&github;/master/plugins/&name;.plg\">" ${APPNAME}.plg

sed -i "s/raw.githubusercontent.com/gitcode.net/g" $(grep "raw.githubusercontent.com" -rl ./)

echo 替换结束
#=================


#=====开始打包====
echo “开始打包”
cd /tmp/GitHub/${APPNAME}/source/${APPNAME}/

chmod 0755 -R .

echo "7zip压缩"
7z a -ttar -r ${APPNAME}-${version}-x86_64-1.tar usr/
7z a -txz -r ${APPNAME}-${version}-x86_64-1.txz ${APPNAME}-${version}-x86_64-1.tar

cp /tmp/GitHub/${APPNAME}/source/${APPNAME}/${APPNAME}-${version}-x86_64-1.txz /github/workspace/${APPNAME}/archive/ -R -v -p -f

md5_data=$(md5sum /github/workspace/${APPNAME}/archive/${APPNAME}-${version}-x86_64-1.txz | cut -d ' ' -f1)

echo "md5_data = ${md5_data}"

cd /github/workspace/${APPNAME}/plugins
sed -i "6c <!ENTITY md5       "\"${md5_data}\"">" ${APPNAME}.plg

echo 打包结束
#=================