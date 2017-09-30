evaluate(new File("./TAD.groovy"))

def preorderWithBracket(abb){
    print '('
	if (!isEmptyTree(abb)){
		if ((!isEmptyTree(leftSon(abb))) || (!isEmptyTree(rightSon(abb)))){
			print ' '+key(abb)+ ' '
			preorderWithBracket(leftSon(abb))
			print ' '
			preorderWithBracket(rightSon(abb))
        }
		else{
			print ' '+key(abb)+ ' '
        }
    }
	print ')'
}

def test(see){
    if (see == 1){
    def tree = emptyTree(null)
    tree = insertKey(tree,4)
    insertKey(tree,4)
    insertKey(tree,2)
    insertKey(tree,6)
    insertKey(tree,1)
    insertKey(tree,3)
    insertKey(tree,5)
    insertKey(tree,7)

    preorderWithBracket(tree)
    print '\n'

    println 'search 1...'+ key(searchKey(tree,1))
    println 'search 2...'+key(searchKey(tree,2))
    println 'search 3...'+key(searchKey(tree,3))
    println 'search 4...'+key(searchKey(tree,4))
    println 'search 5...'+key(searchKey(tree,5))
    println 'search 6...'+key(searchKey(tree,6))
    println 'search 7...'+key(searchKey(tree,7))

    print'remove 5...'
        eraseKey(tree,5)
        preorderWithBracket(tree)
        print '\n'

        print 'remove 6...'
        eraseKey(tree,6)
        preorderWithBracket(tree)
        print '\n'

        print 'remove 4...'
        eraseKey(tree,4)
        preorderWithBracket(tree)
        print '\n'

        print 'remove 2...'
        eraseKey(tree,2)
        preorderWithBracket(tree)
        print '\n'
    }
}

test(1)


