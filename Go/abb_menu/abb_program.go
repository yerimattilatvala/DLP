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

func test( i int) {
	if i ==0 {
		var abb ABB
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

		fmt.Printf("%s%d\n","buscar 1...", key(searchKey(abb,1)))
		fmt.Printf("%s%d\n","buscar 2...", key(searchKey(abb,2)))
		fmt.Printf("%s%d\n","buscar 3...", key(searchKey(abb,3)))
		fmt.Printf("%s%d\n","buscar 4...", key(searchKey(abb,4)))
		fmt.Printf("%s%d\n","buscar 5...", key(searchKey(abb,5)))
		fmt.Printf("%s%d\n","buscar 6...", key(searchKey(abb,6)))
		fmt.Printf("%s%d\n","buscar 7...", key(searchKey(abb,7)))

		fmt.Printf("eliminar 5...\n")		       
		eraseKey(&abb, 5);
		preorderWithBracket(abb) 
		fmt.Printf("\n");

		fmt.Printf("eliminar 6...\n")		       
		eraseKey(&abb, 6);
		preorderWithBracket(abb) 
		fmt.Printf("\n");

		fmt.Printf("eliminar 4...\n")		       
		eraseKey(&abb, 4);
		preorderWithBracket(abb) 
		fmt.Printf("\n");

		fmt.Printf("eliminar 2...\n")		       
		eraseKey(&abb, 2);
		preorderWithBracket(abb) 
		fmt.Printf("\n");
	}
}
