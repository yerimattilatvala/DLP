/*
***** Autor1: Yeray Méndez Romero
***** Login1: yeray.mendez
***** Email1: yeray.mendez@udc.es
***** Autor2: Daniel Rivera López
***** Login2: d.rivera1
***** Email2: d.rivera1@udc.es
*/

package bst.tad

class Node(key: Int){

    var key : Int = key
    var left : Node? = null
    var right : Node? = null
}

//create a new node with the given key
fun createNode(key: Int): Node{
    return Node(key)
}

//return an empty tree
fun emptyTree(): Node?{
    return null
} 

//insert the key into the given tree recursively
fun insert_r(abb_in: Node?, key: Int): Node?{
    var abb = abb_in

	if (abb == null){   // if abb is an empty tree we only need to put a new Node inside
		abb = createNode(key)
    }else{
		if (key < abb.key)		// if the key to insert is lower than the one in abb we call the same function with his left tree
			abb.left = insert_r(abb.left,key)
        else if (key > abb.key)		// if it is higher we call it with the right one
			abb.right = insert_r(abb.right,key)
    }
    return abb
}

//insert the key into the given tree iteratively
fun insert_i(abb_in: Node?,key: Int): Node?{
	var new_node = createNode(key)  // creation of a node containing the key to insert
	var abb = abb_in				// creation of variables 'son' an 'father' to iterate over the nodes of the tree
    var son : Node?
    var father : Node?

	if (abb == null){
		return new_node				// if abb is an empty tree we only need to put a new Node inside	
    }else{
		son = abb
		father = null
		while ((son != null) and (son?.key != key)){	// the iteration takes place until 'son' is null or...
			father = son								// the key to insert is the same as the one in 'son'...
			if (key < son!!.key){						// in each iteration 'son' points to his left or right...
				son = son.left							// son depending of the value of the key to insert...
            }else{										// and father points to the previous value of 'son'
				son = son.right
            }
        }		
		if (son == null){					// if 'son' is null we insert the 'new_node' in the 'son' position...
			if (key < father!!.key){		// but we do not know if 'son' is the right or left son of 'father'.. 
				father.left = new_node		// so we check the key to insert against the key of 'father' to decide
            }else{
				father.right = new_node
            }
        }									// if 'son' is not null the key is already on the tree so there is nothing to do
		return abb
    }
}

//insert the key into the given tree
fun insertKey(abb: Node?,key: Int): Node?{
    return insert_i(abb,key)
}

//search a given value on the given tree recursively and returns the node containing it or null
fun search_r(abb_in: Node?,key: Int): Node?{
    var abb = abb_in

	if (abb == null)  // if the tree is empty the key can not be in it
		return null
	else if (abb.key == key)  // if the current node has the key we just return it
		return abb
	else if (key < abb.key)				// in other case we call the same function over the right...
		return search_r(abb.left,key)	// or left son of the current node depending of the key
	else
		return search_r(abb.right,key)
}

//search a given value on the given tree iteratively and returns the node containing it or null
fun search_i(abb_in: Node?,key: Int): Node?{
	var node = abb_in  // creation of the variable 'node' to iterate over the nodes of abb

	while ((node != null) and (node!!.key != key)){
		if (key < node.key)  // we iterate over 'node' until we get the node with the searched key o null
			node = node.left
		else
			node = node.right
    }
	return node
}

//search a given value on the given tree and returns the node containing it or null
fun	searchKey(abb: Node?,key: Int): Node?{
	return search_r(abb,key)
}	

//return the left son of a given tree
fun leftSon(abb: Node?): Node?{
	return abb?.left
}

//return the right son of a given tree		
fun rightSon(abb: Node?): Node?{
	return abb?.right
}

//return the key of a given tree		
fun key(abb: Node?): Int{
	return abb!!.key
}

//check if a tree is empty		
fun isEmptyTree(abb: Node?): Boolean{
	return (abb == null)
}

//erase a given value in a given tree recursively
fun erase_r(abb_in: Node?,key: Int): Node?{
    var abb = abb_in
	var aux: Node?  // contains abb when the sup2 function is called
    aux = abb 

	fun sup2(tree_in: Node?): Node?{   // puts in the key of 'aux' the higher key of the left tree of abb
        var tree = tree_in

		if (tree?.right != null)
			tree.right = sup2(tree.right)
		else{
			aux?.key = tree!!.key
			return tree.left
        }
		return aux
    }

	if (abb != null){  // if abb is null we have nothing to do
		if (key < abb.key)						// if the key to erase is not the same as the one in the current node...
			abb.left = erase_r(abb.left,key)	// we call erase_r over the left or right son of the current node
		else if (key > abb.key)
			abb.right = erase_r(abb.right,key)
		else{									// if the key of the node is the same as the one to erase..
			aux = abb							// we erase it and asign abb to the rest of the tree 
			if (abb.left == null)
				abb = abb.right
			else if (abb.right == null)
				abb = abb.left
			else
				abb = sup2(abb.left)			// if the node have 2 sons we call sup2
        }
    }
	return abb
}

//erase a given value in a given tree iteratively
fun erase_i(abb_in: Node?,key: Int): Node?{
    var abb = abb_in
	var sons_num: Int			// the number of sons of the node to erase
	var sup: Node?				// node to erase
	var f_sup: Node? = null		// father of the node to erase
	var not_empty_son: Node?	// if the node to erase only have one son this variable points to the one that is not null
	var son_left_max: Node?		// if the node to erase have 2 sons this variable points to the higher value node on the left..
								// of the one to erase
	sup = abb
	while ((sup != null) and (sup?.key != key)){	// iteration ultil we reach the key to erase or null
		f_sup = sup
		if (key < sup!!.key)
			sup = sup.left
		else
			sup = sup.right
    }		
	if (sup != null){
		sons_num = 0
		if (sup.left != null)				// check the number of sons of the node to erase
			sons_num = sons_num + 1
		if (sup.right != null)
			sons_num = sons_num + 1
				
		if (sons_num == 0){					// if it has 0 sons we point the father to null
			if (f_sup == null)
				abb = null
			else if (f_sup.left == sup)
				f_sup.left = null
			else
				f_sup.right = null
					
        }else if (sons_num == 1){			// when the node to erase have one son
			if (sup.left == null)			// check which is the not empty son
				not_empty_son = sup.right
			else	
				not_empty_son = sup.left
				
			if (f_sup == null)				// if the sup node have father--
				abb = not_empty_son 
			else if (f_sup.left == sup)		// put the not empty son in the right position in father
				f_sup.left = not_empty_son
			else
				f_sup.right = not_empty_son
				
        }else{		// when it have 2 sons
			f_sup = sup
			son_left_max = sup.left
			while (son_left_max?.right != null){	// search the max value node of the left tree of sup
				f_sup = son_left_max
				son_left_max = son_left_max.right
            }	
			sup.key = son_left_max!!.key	// change the max key of the left with the one in the node to erase
			if (f_sup == sup)
				f_sup.left = son_left_max.left	// assign father to the lasting tree
			else
				f_sup?.right = son_left_max.left
				
        }
    }	
	return abb
}

//erase a given value in a given tree			
fun eraseKey(abb: Node?,key: Int): Node?{
	return erase_i(abb,key)
}