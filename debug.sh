#!/bin/bash
# 1. 清理缓存（确保无残留旧版本）
go clean -modcache
# 2. 整理依赖并下载最新版本到缓存
go mod tidy

# 3. 锁定依赖到 vendor 目录
go mod vendor
go mod verify
go build -mod=vendor
go get -u ./...
#go mod download
#go clean -cache -modcache -i -r

go build -mod=vendor -gcflags="all=-N -l" 

# 增加系统UDP缓冲区大小
#sudo sysctl -w net.core.rmem_max=2500000
#sudo sysctl -w net.core.wmem_max=2500000

#chmod 7777 /etc/sysctl.conf
# 编辑 /etc/sysctl.conf 添加：
#net.core.rmem_max=2500000
#net.core.wmem_max=2500000
# 然后执行
#sudo sysctl -p

#静态编译 ，生成的可执行文件将不依赖于系统的 glibc 版本，序通常避免了对 libpthread 和 glibc 版本的依赖，但不适用于所有情况，尤其是涉及 C 库的项目。
#CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -installsuffix cgo -o dhtP2PGlobal