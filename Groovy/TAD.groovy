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
    if (abb == null)
        return createNodeA(key)
    else if (key < abb.root)
        abb.left = insert_r(abb.left,key)
    else if (key > abb.root)
        abb.right = insert_r(abb.right,key)
    return abb
}

def insert_i(abb,int key){
    def new_node = createNodeA(key)

    if (abb ==null)
        return new_node
    else{
        def father = null
        def son = abb
		while ((son !=null) && (son.root != key)){
			father = son
			if (key < son.root)
				son = son.left
			else 
				son = son.right
        }
		if (son ==null){
			if (key < father.root)
				father.left = new_node
			else 
				father.right = new_node
        }
		return abb

    }
    
}

def insertKey(abb,int key){
    return insert_i(abb,key)
}

def search_r(abb,int key){
	if (abb ==null)
		return null
	else if (abb.root == key)
		return abb
	else if (key < abb.root)
		return search_r(abb.left,key)
	else
		return search_r(abb.right,key)
}
			
def search_i(abb,int key){
	def node = abb
	while ((node !=null) && (node.root != key)){
		if (key < node.root)
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

//tuven que definila fora que non deixa definir funcions dentro de outras
def sup2(tree,aux){
		if (tree.right!= null)
			tree.right = sup2(tree.right,aux)
		else{
			aux.root = tree.root
			return tree.left
        }
		return aux
    }

def erase_r(abb,int key){
	def aux = null

	if (abb != null){
		if (key < abb.root)
			abb.left = erase_r(abb.left,key)
		else if (key > abb.root)
			abb.right = erase_r(abb.right,key)
		else{
			aux = abb
			if (abb.left == null)
				abb = abb.right
			else if (abb.right == null)
				abb = abb.left
			else
				abb = sup2(abb.left,aux)
			aux = null
        }
    }
	return abb
}			

def erase_i(abb,int key){
	def sons_num = null
	def sup = null
	def f_sup = null
	def not_empty_son = null
	def son_left_max = null
		
	sup = abb
	while ((sup !=null) && (sup.root != key)){
		f_sup = sup
		if (key < sup.root)
			sup = sup.left
		else
			sup = sup.right
    }			
	if (sup !=null){
		sons_num = 0
		if (sup.left != null)
			sons_num = sons_num + 1
		if (sup.right != null)
			sons_num = sons_num + 1
				
		if (sons_num == 0){
			if (f_sup == null)
				abb = null
			else if (f_sup.left == sup)
				f_sup.left = null
			else
				f_sup.right = null
        }		
		else if (sons_num == 1){
			if (sup.left == null)
				not_empty_son = sup.right
			else
				not_empty_son = sup.left
				
			if (f_sup == null)
				abb = not_empty_son
			else if (f_sup.left == sup)
				f_sup.left = not_empty_son
			else
				f_sup.right = not_empty_son
        }
		else{
			f_sup = sup
			son_left_max = sup.left
			while (son_left_max.right != null){
				f_sup = son_left_max
				son_left_max = son_left_max.right
            }
			sup.root = son_left_max.root
			if (f_sup == sup)
				f_sup.left = son_left_max.left
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