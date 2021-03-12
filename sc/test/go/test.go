package main

import (
	"fmt"

	mathClass "./mClass"
)

func main() {
	fmt.Println("Hello, World!")
	fmt.Println(mathClass.Add(1, 2))
	fmt.Println(mathClass.Sub(2, 1))
}

func operator() {
	var a int = 21
	var b int = 10
	var c int

	a += b
	c = a + b
	c = a - b
	c = a * b
	c = a / b
	c = a % b
	c = a&b | b ^ b
	a++
	a = 21 // 为了方便测试，a 这里重新赋值为 21
	a--

	//指针
	var ptr *int
	ptr = &a
	fmt.Printf("a 的值为  %d\n", a)
	fmt.Printf("*ptr 为 %d\n", *ptr)

	var a_b bool = true
	var b_b bool = false
	a_b = (a_b || b_b)
	a_b = !(a_b && b_b)
}

func variable() {
	// 声明一个变量并初始化
	var a = "RUNOOB"
	fmt.Println(a)

	// 没有初始化就为零值
	var b int
	fmt.Println(b)

	// bool 零值为 false
	var c bool
	fmt.Println(c)

	var a *int
	var a []int
	var a map[string]int
	var a chan int
	var a func(string) int
	var a error // error 是接口

	a := 1 //a 已被赋值  不能用 := 省略 var
	aa := 1
	var bb = 1
	aa, cc := 1, 2 //可以 因为cc是新变量
}

const c_name1, c_name2 = value1, value2

const (
	Unknown = 0
	Female  = 1
	Male    = 2
)

const (
	a = iota
	b = iota
	c = iota
)

const (
	a = iota
	b
	c
)
