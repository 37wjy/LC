package mathClass

func add(x, y int) int { //local func
	return x + y
}

func Add(x, y int) int { //global class func
	return add(x, y)
}
