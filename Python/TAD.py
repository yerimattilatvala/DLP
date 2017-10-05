#
#***** Autor1: Yeray Méndez Romero
#***** Login1: yeray.mendez
#***** Email1: yeray.mendez@udc.es
#***** Autor2: Daniel Rivera López
#***** Login2: d.rivera1
#***** Email2: d.rivera1@udc.es
# 

class Node:
	def __init__(self, key):
		self.key = key
		self.left = None
		self.right = None

def createNode(key):
#CreateNodeA(key)->Node(Key,None,None)
#***** Goal: Create a new node.
#***** Input: key.
#***** OutPut: Node(Key,None,None).
#***** PreCondition:
	return Node(key)

def emptyTree(abb):
#Empty Tree(abb)-> None
#***** Goal: Create a empty tree.
#***** Input: Binary Tree
#***** OutPut: None
#***** PreCondition:
	return None

def insert_r(abb,key):
#insert_r(abb,key)-> Tree with new Key.
#***** Goal: Insert key in the right place in the tree.
#***** Input: Binary tree and key.
#***** OutPut: Key inserted in the tree.
#***** PreCondition: Initialized tree.
	if abb is None:
		return createNode(key)
	else:
		if key < abb.key:
			abb.left = insert_r(abb.left,key)
		elif key > abb.key:
			abb.right = insert_r(abb.right,key)
	return abb

def insert_i(abb,key):
#insert_i(abb,key)-> Tree with new Key.
#***** Goal: Insert key in the right place in the tree.
#***** Input: Binary tree and key.
#***** OutPut: Key inserted in the tree.
#***** PreCondition: Initialized tree.
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

def	insertKey(abb,key):
#insertKey(abb,key)-> Tree with new Key.
#***** Goal: Insert key in the right place in the tree.
#***** Input: Binary tree and key.
#***** OutPut: Key inserted in the tree.
#***** PreCondition: Initialized tree.
	return insert_r(abb,key)
		
def search_r(abb,key):
#search_r(abb,key)-> Node that contain the key.
#***** Goal: Return the node which contains the key.
#***** Input: Binary tree and key.
#***** OutPut: Node that contains the key.
#***** PreCondition: Initialized tree.
	if abb is None:
		return None
	elif abb.key == key:
		return abb
	elif key < abb.key:
		return search_r(abb.left,key)
	else:
		return search_r(abb.right,key)

def search_i(abb,key):
#search_i(abb,key)-> Node that contain the key.
#***** Goal: Return the node which contains the key.
#***** Input: Binary tree and key.
#***** OutPut: Node that contains the key.
#***** PreCondition: Initialized tree.
	node = abb
	while node is not None and node.key != key:
		if key < node.key:
			node = node.left
		else:
			node = node.right
	return node

#------------------------Search key----------------------#	
def	searchKey(abb,key):
#searchKey(abb,key)-> Node that contain the key.
#***** Goal: Return the node which contains the key.
#***** Input: Binary tree and key.
#***** OutPut: Node that contains the key.
#***** PreCondition: Initialized tree.
	return search_i(abb,key)	

def leftSon(abb):
#leftSon(abb)-> Left son of the tree.
#***** Goal: Returns the left branch of the tree.
#***** Input: Binary tree not null.
#***** OutPut: Returns the left branch of the tree.
#***** PreCondition: Initialized tree.
	return abb.left

def rightSon(abb):
#rightSon(abb)-> Right son of the tree.
#***** Goal: Returns the right branch of the tree.
#***** Input: Binary tree not null.
#***** OutPut: Returns the left branch of the tree.
#***** PreCondition: Initialized tree.
	return abb.right

def key(abb):
#key(abb)-> Root.
#***** Goal: Returns the root of the tree.
#***** Input: Binary tree not null.
#***** OutPut: Returns the root.
#***** PreCondition:Initialized tree.
	return abb.key

def isEmptyTree(abb):
#isEmptyTree(abb)-> Boolean.
#***** Goal: Indicates if the tree is empty.
#***** Input: Binary tree.
#***** OutPut: Boolean.
#***** PreCondition:Initialized tree.
	return abb is None

def erase_r(abb,key):
#erase_r(abb,key)-> Tree without the key.
#***** Goal: Remove the key from the tree.
#***** Input: Binary tree and key.
#***** OutPut: Tree without the key.
#***** PreCondition:Initialized tree.

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
			
def erase_i(abb,key):
#erase_i(abb,key)-> Tree without the key.
#***** Goal: Remove the key from the tree.
#***** Input: Binary tree and key.
#***** OutPut: Tree without the key.
#***** PreCondition:Initialized tree.
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

def eraseKey(abb,key):
#eraseKey(abb,key)-> Tree without the key.
#***** Goal: Remove the key from the tree.
#***** Input: Binary tree and key.
#***** OutPut: Tree without the key.
#***** PreCondition:Initialized tree.
	return erase_i(abb,key)