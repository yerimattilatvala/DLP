class Node:
	def __init__(self, key):
		self.key = key
		self.left = None
		self.right = None

#------------------------Node Creation-----------------------------#
def createNode(key):
	return Node(key)
	
#------------------------Empty Tree-----------------------------#
def emptyTree(abb):
	return None

#------------------------ Recursive Insert----------------------#
def insert_r(abb,key):
	if abb is None:
		return createNode(key)
	else:
		if key < abb.key:
			abb.left = insert_r(abb.left,key)
		elif key > abb.key:
			abb.right = insert_r(abb.right,key)
	return abb
	
			
#------------------------ Iterative Insert----------------------#
def insert_i(abb,key):
	new_node = createNode(key)
	
	if abb is None:
		return new_node			
	else :
		son = abb
		father = None
		while son is not None and son.key != key:
			father = son
			if key < son.key :
				son = son.left
			else :
				son = son.right
				
		if son is None :
			if key < father.key :
				father.left = new_node
			else :
				father.right = new_node
		return abb
		
#------------------------Insert key----------------------#	
def	insertKey(abb,key):
	return insert_r(abb,key)
		
#------------------------ Recursive Search----------------------#
def search_r(abb,key):
	if abb is None:
		return None
	elif abb.key == key:
		return abb
	elif key < abb.key:
		return search_r(abb.left,key)
	else:
		return search_r(abb.right,key)
			
#------------------------ Iterative Search----------------------#
def search_i(abb,key):
	node = abb
	while node is not None and node.key != key:
		if key < node.key:
			node = node.left
		else:
			node = node.right
	return node

#------------------------Search key----------------------#	
def	searchKey(abb,key):
	return search_i(abb,key)	

#------------------------Left Son----------------------#	
def leftSon(abb):
	return abb.left
		
#------------------------Right Son----------------------#	
def rightSon(abb):
	return abb.right
		
#------------------------Key----------------------#	
def key(abb):
	return abb.key
		
#------------------------Left Son----------------------#	
def isEmptyTree(abb):
	return abb is None
		
#------------------------ Recursive Erase----------------------#
def erase_r(abb,key):
	aux = None

	def sup2(tree):
		if tree.right is not None:
			tree.right = sup2(tree.right)
		else:
			aux.key = tree.key
			#aux = tree
			return tree.left
		return aux

	if abb is not None:
		if key < abb.key:
			abb.left = erase_r(abb.left,key)
		elif key > abb.key:
			abb.right = erase_r(abb.right,key)
		else:
			aux = abb
			if abb.left is None:
				abb = abb.right
			elif abb.right is None:
				abb = abb.left
			else:
				abb = sup2(abb.left)
			aux = None
	return abb
			
#------------------------ Iterative Erase----------------------#
def erase_i(abb,key):
	sons_num = None
	sup = None
	f_sup = None
	not_empty_son = None
	son_left_max = None
		
	f_sup = None
	sup = abb
	while sup is not None and sup.key != key:
		f_sup = sup
		if key < sup.key:
			sup = sup.left
		else:
			sup = sup.right
				
	if sup is not None:
		sons_num = 0
		if sup.left != None:
			sons_num = sons_num + 1
		if sup.right != None:
			sons_num = sons_num + 1
				
		if sons_num == 0:
			if f_sup == None:
				abb = None
			elif f_sup.left == sup:
				f_sup.left = None
			else:
				f_sup.right = None
					
		elif sons_num == 1:
			if sup.left == None:
				not_empty_son = sup.right
			else:	
				not_empty_son = sup.left
				
			if f_sup == None:
				abb = not_empty_son
			elif f_sup.left == sup:
				f_sup.left = not_empty_son
			else:
				f_sup.right = not_empty_son
				
		else:
			f_sup = sup
			son_left_max = sup.left
			while son_left_max.right != None:
				f_sup = son_left_max
				son_left_max = son_left_max.right
				
			sup.key = son_left_max.key
			if f_sup == sup:
				f_sup.left = son_left_max.left
			else:
				f_sup.right = son_left_max.left
				
			sup = son_left_max

		sup = None	
	return abb
		
#------------------------ Erase Key----------------------#				
def eraseKey(abb,key):
	return erase_i(abb,key)