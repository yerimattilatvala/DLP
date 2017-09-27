import bst.tad.*
import bst.test.*

// COMPILE: kotlinc menu.kt -include-runtime -d bst.jar src

fun menu(){
    var abb: Node?
    var exit: Boolean
    var number: Int
    var choice: Int

	print("\n*******************************************")
	print("\nWelcome to ABB's menu of operations")
	print("\n*******************************************")
	print("\n-------------------------------------------")
	exit = false
	abb = emptyTree()

	while (exit == false){
		print("\nPress 1 if you want to insert a number.")
		print("\nPress 2 if you want to delete a value ")
		print("from the tree.")
		print("\nPress 3 if you want to find a value in ")
		print("the tree, showing the corresponding subtree")
		print("per screen.")
		print("\nPress 4 if you want to display the tree by")
		print("screen in parenthesized format.")
        print("\nPress 5 if you want to run the default test")
		print("\nPress 0 if you want to exit the menu")

		try{
			print("\n-------------------------------------------")
			print("\nWhat would you like to do?\n")
            choice = readLine()!!.toInt()
			print("\n-------------------------------------------")
            when (choice){
			    0 -> {
                    exit = true
                    print("\n-------------------------------------------")
                }
			    1 -> {
                    print("\n-------------------------------------------")
                    print("\nInsert a number: ")
                    number = readLine()!!.toInt()
                    abb = insertKey(abb,number)
                    print("\n-------------------------------------------")
                }
			    2 -> {
                    print("\n-------------------------------------------")
                    print("\nInsert a number: ")
                    number = readLine()!!.toInt()
                    abb = eraseKey(abb,number)
                    print("\n-------------------------------------------")
                }
			    3 -> {
                    print("\n-------------------------------------------")
                    preorderWithBracket(abb)
                    print("\nInsert a number that you want to search: ")
                    number = readLine()!!.toInt()
                    print("\nSearch ")
                    print(number)
                    print("... ")
                    print(key(searchKey(abb,number)))
                    print("\n-------------------------------------------")
                }
			    4 -> {
                    print("\n-------------------------------------------\n")
                    preorderWithBracket(abb)
                    print("\n-------------------------------------------")
                }
                5 -> {
                    print("\n-------------------------------------------\n")
                    test()
                    print("\n-------------------------------------------")
                }
                else -> {
                    print("\nThe option is not in the menu, try again.")
                    print("\n-------------------------------------------")
                }
            }
        }catch (e: NumberFormatException){
			print("\n-------------------------------------------")
			print("Your choice is not correct, try again.")
			print("\n-------------------------------------------")
        }
        catch (e: KotlinNullPointerException){
			print("\n-------------------------------------------")
			print("\nThe value is not on the tree.")
			print("\n-------------------------------------------")
        }
    }
}

fun main(args: Array<String>) {
    menu()
}