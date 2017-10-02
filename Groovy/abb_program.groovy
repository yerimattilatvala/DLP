def preorderWithBracket(abb){
    tad = new TAD()
    print '('
	if (!tad.isEmptyTree(abb)){
		if ((!tad.isEmptyTree(tad.leftSon(abb))) || (!tad.isEmptyTree(tad.rightSon(abb)))){
			print ' '+tad.key(abb)+ ' '
			preorderWithBracket(tad.leftSon(abb))
			print ' '
			preorderWithBracket(tad.rightSon(abb))
        }
		else{
			print ' '+tad.key(abb)+ ' '
        }
    }
	print ')'
}

def test(){
    tad = new TAD()
    def tree = tad.emptyTree(null)
    tree = tad.insertKey(tree,4)
    tree = tad.insertKey(tree,4)
    tree = tad.insertKey(tree,2)
    tree = tad.insertKey(tree,6)
    tree = tad.insertKey(tree,1)
    tree = tad.insertKey(tree,3)
    tree = tad.insertKey(tree,5)
    tree = tad.insertKey(tree,7)

    preorderWithBracket(tree)
    print '\n'

    println 'search 1...'+tad.key(tad.searchKey(tree,1))
    println 'search 2...'+tad.key(tad.searchKey(tree,2))
    println 'search 3...'+tad.key(tad.searchKey(tree,3))
    println 'search 4...'+tad.key(tad.searchKey(tree,4))
    println 'search 5...'+tad.key(tad.searchKey(tree,5))
    println 'search 6...'+tad.key(tad.searchKey(tree,6))
    println 'search 7...'+tad.key(tad.searchKey(tree,7))

    print'remove 5...'
    tad.eraseKey(tree,5)
    preorderWithBracket(tree)
    print '\n'

    print 'remove 6...'
    tad.eraseKey(tree,6)
    preorderWithBracket(tree)
    print '\n'

    print 'remove 4...'
    tad.eraseKey(tree,4)
    preorderWithBracket(tree)
    print '\n'

    print 'remove 2...'
    tad.eraseKey(tree,2)
    preorderWithBracket(tree)
    print '\n'

}

