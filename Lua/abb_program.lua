
-- Autor1: Yeray Méndez Romero
-- Login1: yeray.mendez
-- Email1: yeray.mendez@udc.es
-- Autor2: Daniel Rivera López
-- Login2: d.rivera1
-- Email2: d.rivera1@udc.es


local abbTad = require("TAD")

function preorderWithBracket(abb)
    io.write('(')
	if not isEmptyTree(abb) then
		if not isEmptyTree(leftSon(abb)) or  not isEmptyTree(rightSon(abb)) then
			io.write(' ',key(abb),' ')
			preorderWithBracket(leftSon(abb))
			io.write(' ')
			preorderWithBracket(rightSon(abb))
		else
			io.write(' ',key(abb),' ')
        end
    end
	io.write(')')
end

function test()
	local tree
	tree = emptyTree(nil)
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
	tree = eraseKey(tree,6)
	preorderWithBracket(tree)
	print()

	print('remove 4...')
	tree = eraseKey(tree,4)
	preorderWithBracket(tree)
	print()

	print('remove 2...')
	tree = eraseKey(tree,2)
	preorderWithBracket(tree)
	print()
end