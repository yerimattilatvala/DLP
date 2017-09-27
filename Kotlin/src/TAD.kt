package bst.tad

class Node(key: Int){

    var key : Int = key
    var left : Node? = null
    var right : Node? = null
}

//------------------------Node Creation--------------------------//
fun createNode(key: Int): Node{
    return Node(key)
}

//------------------------Empty Tree-----------------------------//
fun emptyTree(): Node?{
    return null
} 

//------------------------ Recursive Insert----------------------//
fun insert_r(abb_in: Node?, key: Int): Node?{
    var abb = abb_in

	if (abb == null){
		abb = createNode(key)
    }else{
		if (key < abb.key)
			abb.left = insert_r(abb.left,key)
        else if (key > abb.key)
			abb.right = insert_r(abb.right,key)
    }
    return abb
}

//------------------------ Iterative Insert----------------------//
fun insert_i(abb_in: Node?,key: Int): Node?{
	var new_node = createNode(key)
	var abb = abb_in
    var son : Node?
    var father : Node?

	if (abb == null){
		return new_node			
    }else{
		son = abb
		father = null
		while ((son != null) and (son?.key != key)){
			father = son
			if (key < son!!.key){
				son = son.left
            }else{
				son = son.right
            }
        }		
		if (son == null){
			if (key < father!!.key){
				father.left = new_node
            }else{
				father.right = new_node
            }
        }
		return abb
    }
}

//-----------------------------Insert key------------------------//
fun insertKey(abb: Node?,key: Int): Node?{
    return insert_i(abb,key)
}

//------------------------ Recursive Search----------------------//
fun search_r(abb_in: Node?,key: Int): Node?{
    var abb = abb_in

	if (abb == null)
		return null
	else if (abb.key == key)
		return abb
	else if (key < abb.key)
		return search_r(abb.left,key)
	else
		return search_r(abb.right,key)
}

//------------------------ Iterative Search----------------------//
fun search_i(abb_in: Node?,key: Int): Node?{
	var node = abb_in

	while ((node != null) and (node!!.key != key)){
		if (key < node.key)
			node = node.left
		else
			node = node.right
    }
	return node
}

//----------------------------Search key-------------------------//
fun	searchKey(abb: Node?,key: Int): Node?{
	return search_r(abb,key)
}	

//-----------------------------Left Son--------------------------//	
fun leftSon(abb: Node?): Node?{
	return abb?.left
}
		
//----------------------------Right Son--------------------------//
fun rightSon(abb: Node?): Node?{
	return abb?.right
}
		
//-------------------------------Key-----------------------------//	
fun key(abb: Node?): Int{
	return abb!!.key
}
		
//----------------------------Left Son---------------------------//	
fun isEmptyTree(abb: Node?): Boolean{
	return (abb == null)
}

//------------------------ Recursive Erase-----------------------//
fun erase_r(abb_in: Node?,key: Int): Node?{
    var abb = abb_in
	var aux: Node?
    aux = abb

	fun sup2(tree_in: Node?): Node?{
        var tree = tree_in

		if (tree?.right != null)
			tree.right = sup2(tree.right)
		else{
			aux?.key = tree!!.key
			return tree.left
        }
		return aux
    }

	if (abb != null){
		if (key < abb.key)
			abb.left = erase_r(abb.left,key)
		else if (key > abb.key)
			abb.right = erase_r(abb.right,key)
		else{
			aux = abb
			if (abb.left == null)
				abb = abb.right
			else if (abb.right == null)
				abb = abb.left
			else
				abb = sup2(abb.left)
        }
    }
	return abb
}

//------------------------- Iterative Erase----------------------//
fun erase_i(abb_in: Node?,key: Int): Node?{
    var abb = abb_in
	var sons_num: Int
	var sup: Node?
	var f_sup: Node? = null
	var not_empty_son: Node?
	var son_left_max: Node?
		
	sup = abb
	while ((sup != null) and (sup?.key != key)){
		f_sup = sup
		if (key < sup!!.key)
			sup = sup.left
		else
			sup = sup.right
    }		
	if (sup != null){
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
					
        }else if (sons_num == 1){
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
				
        }else{
			f_sup = sup
			son_left_max = sup.left
			while (son_left_max?.right != null){
				f_sup = son_left_max
				son_left_max = son_left_max.right
            }	
			sup.key = son_left_max!!.key
			if (f_sup == sup)
				f_sup.left = son_left_max.left
			else
				f_sup?.right = son_left_max.left
				
        }
    }	
	return abb
}

//---------------------------- Erase Key-------------------------//				
fun eraseKey(abb: Node?,key: Int): Node?{
	return erase_i(abb,key)
}