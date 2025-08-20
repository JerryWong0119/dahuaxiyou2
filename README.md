# HotUpdate
```text
《大话西游2》测试网站，由于iOS版Apps做热更新时提供https访问URL
```
# 热更新步骤
## 确认需要更新的文件及版本号
```text
1、打开你的测试手机上的Apps, 在登录界面的左下角你可以看到当前Apps的版本号，例如：1.0.8
2、确定本次热更新所需要的文件，包括：lua、png等等
```
## 制作更新包
```text
1、将上一步骤所确认复制到hotupdate目录下的相应目录下: Lua文件复制到scripts目录，PNG/JPG等图形资源文件复制到res目录下
2、确定版本号，例如：1.0.9，这个版本号比当前Apps版本号(1.0.8)大就行
3、执行脚本: ./build_hotupdate.sh 1.0.9 ./zhenlongjiangshi
4、修改 ./zhenlongjiangshi/version_zhenlongjiangshi.txt 文件中的配置项:
["1.0.9"] = {
    type = 0,
    url = "http://192.168.1.88/dahuaxiyou2/zhenlongjiangshi/",
    size = 0,
    infoFiles = "http://192.168.1.88/dahuaxiyou2/zhenlongjiangshi/files_1.0.9.txt",
    fileUrlPre = "http://192.168.1.88/dahuaxiyou2/zhenlongjiangshi/hotupdatefiles/1.0.9/"
}
5、在内网测试服上测试本次热更新，如果成功了那就发布到外网上吧。（注意：发布前请修改ip地址）
```

