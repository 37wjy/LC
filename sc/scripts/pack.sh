#!/bin/bash
ProjPath="/Users/wjy/Desktop/project/UnicornUnity"
WorkerName="jianyu"
PackageType="Develop"
 
rm -f $ProjPath/AssetBundles/Android/$PackageType/TestServer/res_version.bytes
# rm -f $ProjPath/AssetBundles/Android/$PackageType/TestServer/app_version.bytes

# if [[ ! -d /tmp/hotfix_history ]]; then
#     mkdir /tmp/hotfix_history
# fi
# if [[ ! -d /tmp/hotfix_upload ]]; then
#     mkdir /tmp/hotfix_upload
# fi
# rm -rf /tmp/hotfix_upload/*
# awk -F',' '{print $1}' $ProjPath/AssetBundles/Android/$PackageType/TestServer/assetbundles_crc.list | while read abPath
# do
#     abName=`echo $abPath | awk -F'/' '{print $NF}'`
#     oldAB=`find /tmp/hotfix_history -name "$abName" | grep $abPath`
#     if [[ $? -gt 0 ]]; then
#         echo "New assetbundle -> $abPath"
#         if [[ ! -f $ProjPath/AssetBundles/Android/$PackageType/TestServer/$abPath ]]; then
#             abPath="dynamic/$abPath"
#         fi
#         echo "copy $ProjPath/AssetBundles/Android/$PackageType/TestServer/$abPath to /tmp/hotfix_upload/$abPath"
#         dirName=`dirname /tmp/hotfix_upload/$abPath`
#         if [[ ! -d $dirName ]]; then
#             echo "directory $dirName not exists, creating now..."
#             mkdir -p $dirName
#         fi

#         cp $ProjPath/AssetBundles/Android/$PackageType/TestServer/$abPath /tmp/hotfix_upload/$abPath
#         if [[ $? -gt 0 ]]; then
#             echo "Warning: $ProjPath/AssetBundles/Android/$PackageType/TestServer/$abPath NOT FOUND!!!!! Need manually copy and upload to S3."
#         fi
#     else
#         newAB=`find $ProjPath/AssetBundles/Android/$PackageType/TestServer -name "$abName" | grep $abPath`
#         oldMd5=`md5 -q $oldAB`
#         newMd5=`md5 -q $newAB`
#         echo "old: $oldMd5, new: $newMd5"
#         if [[ $oldMd5 != $newMd5 ]]; then
#             if [[ ! -f $ProjPath/AssetBundles/Android/$PackageType/TestServer/$abPath ]]; then
#                 abPath="dynamic/$abPath"
#             fi
#             echo "copy $ProjPath/AssetBundles/Android/$PackageType/TestServer/$abPath to /tmp/hotfix_upload/$abPath"
#             dirName=`dirname /tmp/hotfix_upload/$abPath`
#             if [[ ! -d $dirName ]]; then
#                 echo "directory $dirName not exists, creating now..."
#                 mkdir -p $dirName
#             fi

#             cp $ProjPath/AssetBundles/Android/$PackageType/TestServer/$abPath /tmp/hotfix_upload/$abPath
#             if [[ $? -gt 0 ]]; then
#                 echo "Warning: $ProjPath/AssetBundles/Android/$PackageType/TestServer/$abPath NOT FOUND!!!!! Need manually copy."
#             fi
#         fi
#     fi
#     echo "Check $abPath Finish"
#     echo ""
# done
# cp $ProjPath/AssetBundles/Android/$PackageType/TestServer/AssetBundles /tmp/hotfix_upload/
# cp $ProjPath/AssetBundles/Android/$PackageType/TestServer/assetbundles_crc.list /tmp/hotfix_upload/
# scp -r /tmp/hotfix_upload/* bole@10.28.0.26:/Users/bole/Desktop/Res/Android/$WorkerName/
# cp -R $ProjPath/AssetBundles/Android/$PackageType/TestServer/* /tmp/hotfix_history/

scp -r $ProjPath/AssetBundles/Android/$PackageType/TestServer/* bole@10.28.0.26:/Users/bole/Desktop/Res/Android/$WorkerName/