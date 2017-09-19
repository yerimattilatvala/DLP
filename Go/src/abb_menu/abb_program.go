package main

import "fmt"

func preorderWithBracket(a ABB) {
	fmt.Printf("(")
	if !isEmptyTree(a){
		if !isEmptyTree(leftSon(a)) || isEmptyTree(rightSon(a)){
			fmt.Printf("%s%d%s"," ",key(a)," ")
			preorderWithBracket(leftSon(a))
			preorderWithBracket(rightSon(a))
		}
		fmt.Printf("%s%d%s"," ",key(a)," ")
	}
	fmt.Printf(")")
}

func main() {
	var abb ABB
	emptyTree(abb)
	insertKey(abb,4)
	preorderWithBracket(abb)
}
