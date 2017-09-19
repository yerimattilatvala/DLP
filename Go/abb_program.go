package main

import "fmt"
import "TAD"

func preorderWithBracket(a ABB) {
	fmt.Printf("(")
	if not isEmptyTree(a){
		if not isEmptyTree(leftSon(a)) || isEmptyTree(righttSon(a)){
			fmt.Printf(" ",key(a)," ")
			preorderWithBracket(leftSon(a))
			preorderWithBracket(rightSon(a))
		}
		fmt.Printf(" ",key(a)," ")
	}
	fmt.Printf(")")
}

