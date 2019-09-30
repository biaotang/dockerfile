# sshd
基于alpine linux镜像，安装了bash、ssh、rsync、tzdata。

时间不采用UTC时间，设置为中国上海时间；语言设置为zh_CN.UTF-8，支持中文

## 环境参数配置
- `USER` 设置SSH用户名，默认root用户
- `PASSWORD` 设置SSH用户密码，默认"alpine@"

## 使用示例
```
docker run -d -p 22:22 -e PASSWORD=<your password> --name=sshd dockerbilltang/sshd
```
