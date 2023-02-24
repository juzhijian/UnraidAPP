#!/bin/sh

#====获取仓库名====
APPNAME=$1
echo "仓库名称=${APPNAME}"
#=================

#====获取版本号====
version_string=$(nl /github/workspace/recycle.bin/recycle.bin.plg | sed -n '5p')
echo ${version_string}
echo ${version_string:25:10}
version=${version_string:25:10}
#=================

#=====设置git=====
git config --global user.name "juzhijian"
git config --global user.email "princergx@live.com"
#=================

echo 运行替换程序成功

#=====替换链接====
echo 开始替换V${version}

mkdir -p "/tmp/GitHub/${APPNAME}/source/${APPNAME}"

tar -zxvf ${APPNAME}-${version}.tgz

cp /github/workspace/${APPNAME}/recycle.bin/* /tmp/GitHub/${APPNAME}/source/${APPNAME} -R -v -p

rm -rf recycle.bin

cd /tmp/GitHub/${APPNAME}/source/${APPNAME}

cp /tmp/GitHub/${APPNAME}/source/${APPNAME}/* /github/workspace/${APPNAME}/source/ -R -v -p -f

#=====更新plg====
cd /github/workspace/${APPNAME}/

sed -i "7,8c <!ENTITY gitURL		\"https://gitcode.net/juzhijian/&name;/-/raw/master\">\n<!ENTITY pluginURL	\"&gitURL;/&name;.plg\">" ${APPNAME}.plg

echo 替换结束
#=================


#=====开始打包====
echo 开始打包

cd /tmp/GitHub/${APPNAME}/source/

chmod 0755 -R .

echo "开始压缩"

tar -zcvf ${APPNAME}-${version}.tgz recycle.bin/

echo "压缩完成"

cp /tmp/GitHub/${APPNAME}/source/${APPNAME}-${version}.tgz /github/workspace/${APPNAME}/ -R -v -p -f

md5_data=$(md5sum /github/workspace/${APPNAME}/${APPNAME}-${version}.txz | cut -d ' ' -f1)

echo "md5_data = ${md5_data}"

cd /github/workspace/${APPNAME}/
sed -i "10c <!ENTITY md5		"\"${md5_data}\"">" ${APPNAME}.plg

echo 打包结束
#=================