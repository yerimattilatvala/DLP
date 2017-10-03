package bst.test
import bst.tad.*

fun preorderWithBracket(abb: Node?){
	print("(")
	if (!isEmptyTree(abb)){
		if  ((!isEmptyTree(leftSon(abb))) or (!isEmptyTree(rightSon(abb)))){
			print(" ")
            print(key(abb))
            print(" ")
			preorderWithBracket(leftSon(abb))
			print(" ")
			preorderWithBracket(rightSon(abb))
        }else{
			print(" ")
            print(key(abb))
            print(" ")
        }
    }
	print(")")
}

fun test() { 
    var tree : Node?
    tree = emptyTree()
    tree = insertKey(tree,4)
	tree = insertKey(tree,4)
	tree = insertKey(tree,2)
	tree = insertKey(tree,6)
	tree = insertKey(tree,1)
	tree = insertKey(tree,3)
	tree = insertKey(tree,5)
	tree = insertKey(tree,7)

	preorderWithBracket(tree)
	println("")

    print("search 1...")
    println(key(searchKey(tree,1)))
	print("search 2...")
    println(key(searchKey(tree,2)))
	print("search 3...")
    println(key(searchKey(tree,3)))
	print("search 4...")
    println(key(searchKey(tree,4)))
	print("search 5...")
    println(key(searchKey(tree,5)))
	print("search 6...")
    println(key(searchKey(tree,6)))
	print("search 7...")
    println(key(searchKey(tree,7)))

	print("remove 5...")
	tree = eraseKey(tree,5)
	preorderWithBracket(tree)
	println("")

	print("remove 6...")
	tree = eraseKey(tree,6)
	preorderWithBracket(tree)
	println("")

	print("remove 4...")
	tree = eraseKey(tree,4)
	preorderWithBracket(tree)
	println("")

	print("remove 2...")
	tree = eraseKey(tree,2)
	preorderWithBracket(tree)
	println("")
}