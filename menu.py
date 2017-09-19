from abb_program import *


def menu():
	print('\n*******************************************')
	print("Welcome to ABB's menu of operations")
	print('*******************************************')
	print('\n-------------------------------------------')
	exit =  False
	abb = emptyTree(None)

	while exit == False:
		choice = 0
		print("Press 1 if you want to insert a number.")
		print("\nPress 2 if you want to delete a value ")
		print("from the tree.")
		print("\nPress 3 if you want to find a value in ")
		print("the tree, showing the corresponding subtree")
		print("per screen.")
		print("\nPress 4 if you want to display the tree by")
		print("screen in parenthesized format.")
		print("\nPress 0 if you want to exit the menu")

		try:
			print('-------------------------------------------')
			choice = int(input("\nWhat would you like to do?\n"))
			print('\n-------------------------------------------')
			if choice == 0:
				exit = True
				print('-------------------------------------------')
				break
			elif choice == 1 :
				print('-------------------------------------------')
				number = int(input("\nInsert a number: "))
				abb = insertKey(abb,number)
				print('\n-------------------------------------------')
			elif choice == 3 :
				print('-------------------------------------------')
				preorderWithBracket(abb)
				number = int(input("\nInsert a number that you want to search: "))
				print('Search',number,'...',searchKey(abb,number))
				print('\n-------------------------------------------')
			elif choice == 4 :
				print('-------------------------------------------')
				preorderWithBracket(abb)
				print('\n-------------------------------------------')
			else :
				print("Your choice is not correct, try again.")
				print('-------------------------------------------\n')
		except:
			print('-------------------------------------------')
			print("Your choice is not correct, try again.")
			print('-------------------------------------------\n')
		

menu()
