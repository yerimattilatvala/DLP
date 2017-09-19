package main

import "fmt"

type tKey int

type tNodeA struct{
	key tKey
	left,right ABB
}

type ABB *tNodeA

func error(s string){
	fmt.Printf(s)
}

func createNodeA() ABB{
	a:= new(tNodeA)
	if a == nil {
		error("  *** abb.createNodeA : No memory\n")
	}
	return a
}

func emptyTree(a ABB) ABB{
	a = nil
	return a
}

func insert_r(a ABB, key tKey) ABB{
	if a == nil{
		a = createNodeA()
		a.key = key
		a.left = nil
		a.right = nil
	}else if key < a.key{
		insert_r(a.left,key)
	}else {
		insert_r(a.right,key)
	}
	return a
}

func insertKey(a ABB , key tKey) ABB{
	return insert_r(a,key)
}

func leftSon(a ABB) ABB{
	return a.left
}

func rightSon(a ABB) ABB{
	return a.right
}

func key(a ABB) tKey{
	return a.key
}

func isEmptyTree(a ABB) bool{
	return a == nil
}

func main() {
	fmt.Printf("Hola")
}