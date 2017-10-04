package main 

import "fmt"

func main(){
	var exit = 0
	var input int
	var input2,r tKey
	var abb ABB
	var root *tKey

	emptyTree(&abb)
	fmt.Printf("\n*******************************************\n")
	fmt.Printf("Welcome to ABB's menu of operations\n")
	fmt.Printf("*******************************************")
	fmt.Printf("\n-------------------------------------------\n")
	RESTART:
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
			_, err := fmt.Scan(&input)
			if err != nil {
				fmt.Printf("\n-------------------------------------------\n")
				fmt.Printf("\nError, do not enter a letter.\n")
				fmt.Printf("\n-------------------------------------------\n")
				goto RESTART
			}
			//fmt.Scan(&input)
			fmt.Printf("\n-------------------------------------------\n")
			
			if input ==0{
				exit = 1
				fmt.Printf("\n-------------------------------------------\n")
			}else if input == 1 {
				fmt.Printf("\n-------------------------------------------\n")
				fmt.Printf("\nInsert a number: ")
				_, err := fmt.Scan(&input2)
				if err != nil {
					fmt.Printf("\n-------------------------------------------\n")
					fmt.Printf("\nError, do not enter a letter.\n")
					fmt.Printf("\n-------------------------------------------\n")
					goto RESTART
				}
				insertKey(&abb,input2)
				fmt.Printf("\n-------------------------------------------\n")		
			}else if input == 2 {
				fmt.Printf("\n-------------------------------------------\n")
				fmt.Printf("\nInsert a number that you want to the delete: ")
				_, err := fmt.Scan(&input2)
				if err != nil {
					fmt.Printf("\n-------------------------------------------\n")
					fmt.Printf("\nError, do not enter a letter.\n")
					fmt.Printf("\n-------------------------------------------\n")
					goto RESTART
				}
				eraseKey(&abb,input2)
				fmt.Printf("\n-------------------------------------------\n")		
			} else if input == 3 {
				fmt.Printf("\n-------------------------------------------\n")
				preorderWithBracket(abb)
				fmt.Printf("\nInsert a number that you want to search: ")
				_, err := fmt.Scan(&input2)
				if err != nil {
					fmt.Printf("\n-------------------------------------------\n")
					fmt.Printf("\nError, do not enter a letter.\n")
					fmt.Printf("\n-------------------------------------------\n")
					goto RESTART
				}
				if searchKey(abb,input2) == nil {
					fmt.Printf("\n-------------------------------------------\n")
					fmt.Printf("\nError, do not search for a number that contains the tree.\n")
					fmt.Printf("\n-------------------------------------------\n")
					goto RESTART
				}
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