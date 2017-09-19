package main

import "fmt"

func preorderWithBracket(a ABB) {
	fmt.Printf("(")
	if !isEmptyTree(a){
		if !isEmptyTree(leftSon(a)) || !isEmptyTree(rightSon(a)){
			fmt.Printf("%s%d%s"," ",key(a)," ")
			preorderWithBracket(leftSon(a))
			fmt.Printf(" ")
			preorderWithBracket(rightSon(a))
		}else{
			fmt.Printf("%s%d%s"," ",key(a)," ")
		} 
	}
	
	fmt.Printf(")")
}

func main() {
	var abb ABB
	abb = &tNodeA{4,nil,nil}
	emptyTree(&abb)

	insertKey(&abb,4)
	insertKey(&abb,4)
	insertKey(&abb,2)
	insertKey(&abb,6)
	insertKey(&abb,1)
	insertKey(&abb,3)
	insertKey(&abb,5)
	insertKey(&abb,7)
	preorderWithBracket(abb)
	fmt.Printf("\n")
}
