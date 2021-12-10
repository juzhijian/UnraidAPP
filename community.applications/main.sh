#!/bin/sh

#====获取版本号====
version_string=$(nl /github/workspace/community.applications/plugins/community.applications.plg | sed -n '5p')
echo ${version_string}
echo ${version_string:27:10}
version=${version_string:27:10}
#=================
echo 运行替换程序成功

git config --global user.name "聚指尖"
git config --global user.email "admin@juzhijian.com"

echo 开始替换V$version

mkdir -p "/tmp/GitHub/community.applications/source/community.applications/usr/local/emhttp/plugins/community.applications/"
cd archive
tar xJvf community.applications-${version}-x86_64-1.txz
cp /github/workspace/community.applications/archive/usr/local/emhttp/plugins/community.applications/* /tmp/GitHub/community.applications/source/community.applications/usr/local/emhttp/plugins/community.applications -R -v -p
rm -rf usr
cd /tmp/GitHub/community.applications/source/community.applications/usr/local/emhttp/plugins/community.applications

sed -i "s/https:\/\/raw.githubusercontent.com\/Squidly271\/Community-Applications-Moderators\/master\//https:\/\/juzhijian.coding.net\/p\/unraidapp\/d\/Community-Applications-Moderators\/git\/raw\/master\//g" $(grep "https://raw.githubusercontent.com/Squidly271/Community-Applications-Moderators/master/" -rl ./)

sed -i "s/https:\/\/raw.githubusercontent.com\/Squidly271\/AppFeed\/master\//https:\/\/juzhijian.coding.net\/p\/unraidapp\/d\/AppFeed\/git\/raw\/master\//g" $(grep "https://raw.githubusercontent.com/Squidly271/AppFeed/master/" -rl ./)

sed -i "s/https:\/\/raw.githubusercontent.com\/Squidly271\/community.applications\/master\//https:\/\/juzhijian.coding.net\/p\/unraidapp\/d\/community.applications\/git\/raw\/master\//g" $(grep "https://raw.githubusercontent.com/Squidly271/community.applications/master/" -rl ./)

rm -f ca.md5
find . -type f -exec md5sum {} + >/tmp/ca.md5
mv /tmp/ca.md5 ca.md5

cp /tmp/GitHub/community.applications/source/community.applications/usr/local/emhttp/plugins/community.applications/* /github/workspace/community.applications/source/community.applications/usr/local/emhttp/plugins/community.applications -R -v -p -f

cd /github/workspace/community.applications/plugins
sed -i '9,10c <!ENTITY github    "p/unraidapp/d/community.applications/git/raw">\n<!ENTITY pluginURL "https://juzhijian.coding.net/&github;/master/plugins/&name;.plg">' community.applications.plg

echo 替换结束

echo 开始打包
cd /tmp/GitHub/community.applications/source/community.applications/

tar -cvf community.applications-${version}-x86_64-1.txz usr/

cp /tmp/GitHub/community.applications/source/community.applications/community.applications-${version}-x86_64-1.txz /github/workspace/community.applications/archive/ -R -v -p -f

md5_data=$(md5sum /tmp/GitHub/community.applications/source/community.applications/community.applications-${version}-x86_64-1.txz | cut -d ' ' -f1)

echo "md5_data = ${md5_data}"

cd /github/workspace/community.applications/plugins
sed -i "6c <!ENTITY md5       "\"${md5_data}\"">" community.applications.plg

echo 打包结束
