package main 

import "fmt"

func main(){
	var exit = 0
	var input int
	var input2 tKey
	var abb ABB

	emptyTree(&abb)
	fmt.Printf("\n*******************************************\n")
	fmt.Printf("Welcome to ABB's menu of operations\n")
	fmt.Printf("*******************************************")
	fmt.Printf("\n-------------------------------------------\n")

	for exit != 1{
		fmt.Printf("Press 1 if you want to insert a number.")
		fmt.Printf("\nPress 2 if you want to delete a value ")
		fmt.Printf("from the tree.")
		fmt.Printf("\nPress 3 if you want to find a value in ")
		fmt.Printf("the tree, showing the corresponding subtree")
		fmt.Printf("per screen.")
		fmt.Printf("\nPress 4 if you want to display the tree by")
		fmt.Printf("screen in parenthesized format.")
		fmt.Printf("\nPress 5 if you want to run the default test.")
		fmt.Printf("\nPress 0 if you want to exit the menu.")

		fmt.Printf("\n-------------------------------------------\n")
		fmt.Printf("\nWhat would you like to do? \n")
		fmt.Scan(&input)
		fmt.Printf("\n-------------------------------------------\n")
		
		if input ==0{
			exit = 1
			fmt.Printf("\n-------------------------------------------\n")
		}else if input == 1 {
			fmt.Printf("\n-------------------------------------------\n")
			fmt.Printf("\nInsert a number: ")
			fmt.Scan(&input2)
			insertKey(&abb,input2)
			fmt.Printf("\n-------------------------------------------\n")		
		}else if input == 2 {
			fmt.Printf("\n-------------------------------------------\n")
			fmt.Printf("\nInsert a number that you want to the delete: ")
			fmt.Scan(&input2)
			eraseKey(&abb,input2)
			fmt.Printf("\n-------------------------------------------\n")		
		} else if input == 3 {
			fmt.Printf("\n-------------------------------------------\n")
			preorderWithBracket(abb)
			fmt.Printf("\nInsert a number that you want to search: ")
			fmt.Scan(&input2)
			fmt.Printf("\n%s%d%d","Search number... ",input2,key(searchKey(abb,input2)))
			fmt.Printf("\n-------------------------------------------\n")

		}else if input == 4 {
			fmt.Printf("\n-------------------------------------------\n")
			preorderWithBracket(abb)
			fmt.Printf("\n-------------------------------------------\n")		
		}else if input == 5 {
			fmt.Printf("\n-------------------------------------------\n")
			test()
			fmt.Printf("\n-------------------------------------------\n")		
		}else{
		fmt.Printf("The option is not in the menu, try again.\n")
		fmt.Printf("-------------------------------------------\n")
		}	
	}
}