/*
***** Autor1: Yeray Méndez Romero
***** Login1: yeray.mendez
***** Email1: yeray.mendez@udc.es
***** Autor2: Daniel Rivera López
***** Login2: d.rivera1
***** Email2: d.rivera1@udc.es
*/

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
	if *a == nil{		// if abb is an empty tree we only need to put a new Node inside
		createNodeA(a)
		(*a).key = key
		(*a).left = nil
		(*a).right = nil
	}else if key < (*a).key{	// if abb is an empty tree we only need to put a new Node inside
		insert_r(&(*a).left,key)
	}else if key > (*a).key{	// if it is higher we call it with the right one
		insert_r(&(*a).right,key)
	}
}

func insert_i(a *ABB, key tKey){
	var new, father, son ABB	// creation of variables 'son' an 'father' to iterate over the nodes of the tree
	createNodeA(&new)	//creation of a node containing the key to insert
	(*new).key = key
	(*new).left = nil
	(*new).right = nil
	if *a == nil{
		*a = new
	} else {
		father = nil
		son = *a
		for son != nil && (*son).key != key {	// the iteration takes place until 'son' is null or...
			father = son						// the key to insert is the same as the one in 'son'...
			if key < (*son).key {				// in each iteration 'son' points to his left or right...
				son = (*son).left				// son depending of the value of the key to insert...
			} else {							// and father points to the previous value of 'son'
				son = (*son).right
			}
		}
		if son == nil{					// if 'son' is null we insert the 'new_node' in the 'son' position...
			if key < (*father).key{		// but we do not know if 'son' is the right or left son of 'father'.. 
				(*father).left = new	// so we check the key to insert against the key of 'father' to decide
			} else{
				(*father).right = new
			}
		}								// if 'son' is not null the key is already on the tree so there is nothing to do
	}
}

func insertKey(a *ABB , key tKey){
	insert_i(a,key)
}

func search_r(a ABB ,key tKey) ABB{
	if a == nil{		// if the tree is empty the key can not be in it
		return nil
	} else if (*a).key == key{	// if the current node has the key we just return it
		return a
	} else if key < (*a).key {	// in other case we call the same function over the right...
		return search_r((*a).left,key)	// or left son of the current node depending of the key
	} else{
		return search_r((*a).right,key)
	}
}

func search_i(a ABB ,key tKey) ABB{
	var node ABB
	node = a	// creation of the variable 'node' to iterate over the nodes of abb
	for node!=nil && (*node).key != key{
		if key < (*node).key {	// we iterate over 'node' until we get the node with the searched key o null
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
	var aux ABB	//contains abb when the sup2 function is called
	var sup2 func(b *ABB)	//  puts in the key of 'aux' the higher key of the left tree of abb

	sup2 = func(b *ABB){
		if (*b).right != nil{
			sup2(&(*b).right)
		} else{
			(*aux).key = (*b).key
			aux = *b
			*b = (*b).left
		}
	}

	if *a != nil{	// if abb is null we have nothing to do
		if key < (*a).key{				// if the key to erase is not the same as the one in the current node...
			erase_r(&(*a).left,key)		// we call erase_r over the left or right son of the current node
		} else if key > (*a).key{
			erase_r(&(*a).right,key)
		} else{							// if the key of the node is the same as the one to erase..
			aux = *a					// we erase it and asign abb to the rest of the tree 
			if (*a).left == nil{
				*a = (*a).right
			}else if (*a).right == nil{
				*a = (*a).left
			} else{
				sup2(&(*a).left)		// if the node have 2 sons we call sup2 
			}
		}
	}
}

func erase_i(a *ABB, key tKey){
	var numSons int		// the number of sons of the node to erase
	var sup  ABB		// node to erase
	var fSup ABB		// father of the node to erase
	var emptySon ABB	// if the node to erase only have one son this variable points to the one that is not null
	var supIsMax ABB	// if the node to erase have 2 sons this variable points to the higher value node on the left..
						// of the one to erase
	fSup = nil
	sup = *a
	for sup != nil && (*sup).key != key{ //iteration ultil we reach the key to erase or null
		fSup = sup
		if key < (*sup).key{
			sup = (*sup).left
		} else {
			sup = (*sup).right
			
		}
	}
	if sup != nil{
		numSons = 0
		if (*sup).left != nil{			// check the number of sons of the node to erase
			numSons++
		}
		if (*sup).right != nil{
			numSons++
		}

		switch numSons {
		case 0: 						// if it has 0 sons we point the father to null
			if fSup == nil{
				*a = nil
			} else if (*fSup).left == sup {
				(*fSup).left = nil
			} else {
				(*fSup).right = nil
			}
		case 1:							// when the node to erase have one son
			if (*sup).left == nil{		// check which is the not empty son
				emptySon = (*sup).right
			} else{
				emptySon = (*sup).left
			}

			if fSup == nil{				// if the sup node have father--
				*a = emptySon
			} else if (*fSup).left == sup{	// put the not empty son in the right position in father
				(*fSup).left = emptySon
			} else{
				(*fSup).right = emptySon
			}
		case 2:		// when it have 2 sons
			fSup = sup
			supIsMax = (*sup).left
			for (*supIsMax).right != nil{		// search the max value node of the left tree of sup
				fSup = supIsMax
				supIsMax = (*supIsMax).right
			}

			(*sup).key = (*supIsMax).key		// change the max key of the left with the one in the node to erase
			if fSup == sup{
				(*fSup).left = (*supIsMax).left	// assign father to the lasting tree
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


