/*
***** Autor1: Yeray Méndez Romero
***** Login1: yeray.mendez
***** Email1: yeray.mendez@udc.es
***** Autor2: Daniel Rivera López
***** Login2: d.rivera1
***** Email2: d.rivera1@udc.es
*/

class Node{
    def root
    def left
    def right
    
    def Node(int k,l,r){
        this.root = k
        this.left = l
        this.right = r
    }
}

def createNodeA(int key){
    return new Node(key,null,null)
}

def emptyTree(abb){
    return null
}

def insert_r(abb,int key){
    if (abb == null)   // if abb is an empty tree we only need to put a new Node inside
        return createNodeA(key)
    else if (key < abb.root)   // if the key to insert is lower than the one in abb we call the same function with his left tree
        abb.left = insert_r(abb.left,key)
    else if (key > abb.root) // if it is higher we call it with the right one
        abb.right = insert_r(abb.right,key)
    return abb
}

def insert_i(abb,int key){
    def new_node = createNodeA(key) // creation of a node containing the key to insert

    if (abb ==null)
        return new_node  // if abb is an empty tree we only need to put a new Node inside
    else{
        def father = null //creation of variables 'son' an 'father' to iterate over the nodes of the tree
        def son = abb
		while ((son !=null) && (son.root != key)){  // the iteration takes place until 'son' is null or...
			father = son						    // the key to insert is the same as the one in 'son'...
			if (key < son.root)						// in each iteration 'son' points to his left or right...
				son = son.left						// son depending of the value of the key to insert...
			else 									// and father points to the previous value of 'son'
				son = son.right
        }
		if (son ==null){				   // if 'son' is null we insert the 'new_node' in the 'son' position...
			if (key < father.root)		   // but we do not know if 'son' is the right or left son of 'father'..
				father.left = new_node     // so we check the key to insert against the key of 'father' to decide
			else 
				father.right = new_node
        }								   // if 'son' is not null the key is already on the tree so there is nothing to do
		return abb

    }
}

def insertKey(abb,int key){
    return insert_i(abb,key)
}

def search_r(abb,int key){
	if (abb ==null)   // if the tree is empty the key can not be in it
		return null
	else if (abb.root == key)  // if the current node has the key we just return it
		return abb
	else if (key < abb.root)              // in other case we call the same function over the right...
		return search_r(abb.left,key)     // or left son of the current node depending of the key
	else
		return search_r(abb.right,key)
}

def search_i(abb,int key){
	def node = abb   // creation of the variable 'node' to iterate over the nodes of abb
	while ((node !=null) && (node.root != key)){
		if (key < node.root)    // we iterate over 'node' until we get the node with the searched key o null
			node = node.left
		else
			node = node.right
    }
	return node
}

def	searchKey(abb,int key){
	return search_r(abb,key)
}

def isEmptyTree(abb){
    return abb == null
}

def key(abb){
    return abb.root
}

def leftSon(abb){
    return abb.left
}

def rightSon(abb){
    return abb.right
}

//Auxiliar function of erase_r
def sup2(tree,aux){   //puts in the key of 'aux' the higher key of the left tree of abb
	if (tree.right!= null)
		tree.right = sup2(tree.right,aux)
	else{
		aux.root = tree.root
		return tree.left
	}
	return aux
}

def erase_r(abb,int key){
	def aux = null   // contains abb when the sup2 function is called

	if (abb != null){		// if abb is null we have nothing to do
		if (key < abb.root)                         // if the key to erase is not the same as the one in the current node...
			abb.left = erase_r(abb.left,key)		// we call erase_r over the left or right son of the current node
		else if (key > abb.root)
			abb.right = erase_r(abb.right,key)
		else{										// if the key of the node is the same as the one to erase..
			aux = abb								// we erase it and asign abb to the rest of the tree
			if (abb.left == null)
				abb = abb.right
			else if (abb.right == null)
				abb = abb.left
			else				
				abb = sup2(abb.left,aux)			// if the node have 2 sons we call sup2 
			aux = null
        }
    }
	return abb
}			

def erase_i(abb,int key){
	def sons_num = null			// the number of sons of the node to erase
	def sup = null				// node to erase
	def f_sup = null			// father of the node to erase
	def not_empty_son = null	// if the node to erase only have one son this variable points to the one that is not null
	def son_left_max = null		// if the node to erase have 2 sons this variable points to the higher value node on the left..
								// of the one to erase
	sup = abb 
	while ((sup !=null) && (sup.root != key)){ // iteration ultil we reach the key to erase or null
		f_sup = sup
		if (key < sup.root)
			sup = sup.left
		else
			sup = sup.right
    }			
	if (sup !=null){
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
        }		
		else if (sons_num == 1){			// when the node to erase have one son
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
        }
		else{    // when it have 2 sons
			f_sup = sup
			son_left_max = sup.left
			while (son_left_max.right != null){			// search the max value node of the left tree of sup
				f_sup = son_left_max
				son_left_max = son_left_max.right
            }
			sup.root = son_left_max.root				// change the max key of the left with the one in the node to erase
			if (f_sup == sup)
				f_sup.left = son_left_max.left			// assign father to the lasting tree
			else
				f_sup.right = son_left_max.left
				
			sup = son_left_max
        }
		sup = null	
    }
	return abb
}

def eraseKey(abb,int key){
	return erase_r(abb,key)
}