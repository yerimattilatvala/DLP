from tad import *


choice = 1
def preorderWithBracket(abb):
	print('(', end="")
	if not isEmptyTree(abb):
		if not isEmptyTree(leftSon(abb)) or not isEmptyTree(rightSon(abb)):
			print(' ',key(abb),' ', end="")
			preorderWithBracket(leftSon(abb))
			print(' ', end="")
			preorderWithBracket(rightSon(abb))
		else:
			print(' ',key(abb),' ', end="")
	print(')', end="")
		
if choice==1:
	tree = emptyTree(None)
	tree = insertKey(tree,4)
	tree = insertKey(tree,4)
	tree = insertKey(tree,2)
	tree = insertKey(tree,6)
	tree = insertKey(tree,1)
	tree = insertKey(tree,3)
	tree = insertKey(tree,5)
	tree = insertKey(tree,7)

	preorderWithBracket(tree)
	print()
	
	print('search 1...',key(searchKey(tree,1)))
	print('search 2...',key(searchKey(tree,2)))
	print('search 3...',key(searchKey(tree,3)))
	print('search 4...',key(searchKey(tree,4)))
	print('search 5...',key(searchKey(tree,5)))
	print('search 6...',key(searchKey(tree,6)))
	print('search 7...',key(searchKey(tree,7)))

	print('remove 5...')
	tree = eraseKey(tree,5)
	preorderWithBracket(tree)
	print()

	print('remove 6...')
	eraseKey(tree,6)
	preorderWithBracket(tree)
	print()

	print('remove 4...')
	eraseKey(tree,4)
	preorderWithBracket(tree)
	print()

	print('remove 2...')
	eraseKey(tree,2)
	preorderWithBracket(tree)
	print()