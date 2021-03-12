package mathClass

func Sub(x, y int) int {
	return x - y
}


GO111MODULE = off 无模块支持，go 会从 GOPATH 和 vendor 文件夹寻找包。
GO111MODULE = on 模块支持，go 会忽略 GOPATH 和 vendor 文件夹，只根据 go.mod 下载依赖。
GO111MODULE = auto 在 $GOPATH/src 外面且根目录有 go.mod 文件时，开启模块支持。