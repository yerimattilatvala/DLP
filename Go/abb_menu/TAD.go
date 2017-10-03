package main

type tKey int

type tNodeA struct{
	key tKey
	left,right ABB
}

type ABB *tNodeA

func createNodeA(a *ABB){
	*a = new(tNodeA)
}

func emptyTree(a *ABB) {
	*a = nil
}

func insert_r(a *ABB, key tKey){
	if *a == nil{
		createNodeA(a)
		(*a).key = key
		(*a).left = nil
		(*a).right = nil
	}else if key < (*a).key{
		insert_r(&(*a).left,key)
	}else if key > (*a).key{
		insert_r(&(*a).right,key)
	}
}

func insert_i(a *ABB, key tKey){
	var new, father, son ABB
	createNodeA(&new)
	(*new).key = key
	(*new).left = nil
	(*new).right = nil
	if *a == nil{
		*a = new
	} else {
		father = nil
		son = *a
		for son != nil && (*son).key != key {
			father = son
			if key < (*son).key {
				son = (*son).left
			} else {
				son = (*son).right
			}
		}
		if son == nil{
			if key < (*father).key{
				(*father).left = new
			} else{
				(*father).right = new
			}

		}
	}
}

func insertKey(a *ABB , key tKey){
	insert_i(a,key)
}

func search_r(a ABB ,key tKey) ABB{
	if a == nil{
		return nil
	} else if (*a).key == key{
		return a
	} else if key < (*a).key {
		return search_r((*a).left,key)
	} else{
		return search_r((*a).right,key)
	}
}

func search_i(a ABB ,key tKey) ABB{
	var node ABB
	node = a
	for node!=nil && (*node).key != key{
		if key < (*node).key {
			node = (*node).left
		} else{
			node = (*node).right
		}
	}
	return node
}

func searchKey(a ABB, key tKey) ABB{
	return search_i(a,key)
}

func leftSon(a ABB) ABB{
	return a.left
}

func rightSon(a ABB) ABB{
	return a.right
}

func key(a ABB) tKey{
	return a.key
}

func isEmptyTree(a ABB) bool{
	return a == nil
}

func erase_r(a *ABB, key tKey){
	var aux ABB
	var sup2 func(b *ABB)

	sup2 = func(b *ABB){
		if (*b).right != nil{
			sup2(&(*b).right)
		} else{
			(*aux).key = (*b).key
			aux = *b
			*b = (*b).left
		}
	}

	if *a != nil{
		if key < (*a).key{
			erase_r(&(*a).left,key)
		} else if key > (*a).key{
			erase_r(&(*a).right,key)
		} else{
			aux = *a
			if (*a).left == nil{
				*a = (*a).right
			}else if (*a).right == nil{
				*a = (*a).left
			} else{
				sup2(&(*a).left)
			}
		}
	}
}

func erase_i(a *ABB, key tKey){
	var numSons int
	var sup, fSup, emptySon, supIsMax ABB

	fSup = nil
	sup = *a
	for sup != nil && (*sup).key != key{
		fSup = sup
		if key < (*sup).key{
			sup = (*sup).left
		} else {
			sup = (*sup).right
			
		}
	}
	if sup != nil{
		numSons = 0
		if (*sup).left != nil{
			numSons++
		}
		if (*sup).right != nil{
			numSons++
		}

		switch numSons {
		case 0: 
			if fSup == nil{
				*a = nil
			} else if (*fSup).left == sup {
				(*fSup).left = nil
			} else {
				(*fSup).right = nil
			}
		case 1:
			if (*sup).left == nil{
				emptySon = (*sup).right
			} else{
				emptySon = (*sup).left
			}

			if fSup == nil{
				*a = emptySon
			} else if (*fSup).left == sup{
				(*fSup).left = emptySon
			} else{
				(*fSup).right = emptySon
			}
		case 2:	
			fSup = sup
			supIsMax = (*sup).left
			for (*supIsMax).right != nil{
				fSup = supIsMax
				supIsMax = (*supIsMax).right
			}

			(*sup).key = (*supIsMax).key
			if fSup == sup{
				(*fSup).left = (*supIsMax).left
			} else {
				(*fSup).right = (*supIsMax).left
			}
			sup = supIsMax
		}
	} 

}

func eraseKey(a *ABB, key tKey){
	erase_r(a,key)
}


