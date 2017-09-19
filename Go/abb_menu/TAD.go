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

func createNodeA(a *ABB){
	*a = new(tNodeA)
	if a == nil {
		error("  *** abb.createNodeA : No memory\n")
	}
}

func emptyTree(a *ABB) {
	*a = nil
}

func insert_r(a *ABB, key tKey){
	if *a == nil{
		createNodeA(a)
		(*a).key = key
		(*a).left = nil
		(*a).right = nil
	}else if key < (*a).key{
		insert_r(&(*a).left,key)
	}else if key > (*a).key{
		insert_r(&(*a).right,key)
	}
}

func insertKey(a *ABB , key tKey){
	insert_r(a,key)
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

