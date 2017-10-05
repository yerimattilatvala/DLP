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
	if abb is None:          # if abb is an empty tree we only need to put a new Node inside
		return createNode(key)
	else:
		if key < abb.key:    # if the key to insert is lower than the one in abb we call the same function with his left tree
			abb.left = insert_r(abb.left,key)
		elif key > abb.key:  # if it is higher we call it with the right one
			abb.right = insert_r(abb.right,key)
	return abb

def insert_i(abb,key):
#insert_i(abb,key)-> Tree with new Key.
#***** Goal: Insert key in the right place in the tree.
#***** Input: Binary tree and key.
#***** OutPut: Key inserted in the tree.
#***** PreCondition: Initialized tree.
	new_node = createNode(key)    # creation of a node containing the key to insert
	
	if abb is None:
		return new_node	   # if abb is an empty tree we only need to put a new Node inside			
	else :
		son = abb          # creation of variables 'son' an 'father' to iterate over the nodes of the tree
		father = None
		while son is not None and son.key != key:  # the iteration takes place until 'son' is null or...
			father = son						   # the key to insert is the same as the one in 'son'...
			if key < son.key :                     # in each iteration 'son' points to his left or right...
				son = son.left                     # son depending of the value of the key to insert...
			else :								   # and father points to the previous value of 'son'
				son = son.right
				
		if son is None :						   # if 'son' is null we insert the 'new_node' in the 'son' position...
			if key < father.key :                  # but we do not know if 'son' is the right or left son of 'father'.. 
				father.left = new_node             # so we check the key to insert against the key of 'father' to decide
			else :
				father.right = new_node
		return abb                                 # if 'son' is not null the key is already on the tree so there is nothing to do

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
	if abb is None:         # if the tree is empty the key can not be in itif the tree is empty the key can not be in it
		return None
	elif abb.key == key:    # if the current node has the key we just return it
		return abb
	elif key < abb.key:                    # in other case we call the same function over the right...
		return search_r(abb.left,key)      # or left son of the current node depending of the key
	else:
		return search_r(abb.right,key)

def search_i(abb,key):
#search_i(abb,key)-> Node that contain the key.
#***** Goal: Return the node which contains the key.
#***** Input: Binary tree and key.
#***** OutPut: Node that contains the key.
#***** PreCondition: Initialized tree.
	node = abb    # reation of the variable 'node' to iterate over the nodes of abb
	while node is not None and node.key != key:
		if key < node.key:    # we iterate over 'node' until we get the node with the searched key o null
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

	aux = None          # contains abb when the sup2 function is called

	def sup2(tree):     # puts in the key of 'aux' the higher key of the left tree of abb
		if tree.right is not None:
			tree.right = sup2(tree.right)
		else:
			aux.key = tree.key
			#aux = tree
			return tree.left
		return aux

	if abb is not None:   # if abb is null we have nothing to do
		if key < abb.key:                           # if the key to erase is not the same as the one in the current node...
			abb.left = erase_r(abb.left,key)        # we call erase_r over the left or right son of the current node 
		elif key > abb.key:
			abb.right = erase_r(abb.right,key)
		else:                                       # if the key of the node is the same as the one to erase..
			aux = abb                               # we erase it and asign abb to the rest of the tree
			if abb.left is None:
				abb = abb.right
			elif abb.right is None:
				abb = abb.left
			else:
				abb = sup2(abb.left)                # if the node have 2 sons we call sup2 
			aux = None
	return abb
			
def erase_i(abb,key):
#erase_i(abb,key)-> Tree without the key.
#***** Goal: Remove the key from the tree.
#***** Input: Binary tree and key.
#***** OutPut: Tree without the key.
#***** PreCondition:Initialized tree.
	sons_num = None              # the number of sons of the node to erase
	sup = None					 # node to erase
	f_sup = None				 # father of the node to erase
	not_empty_son = None		 # if the node to erase only have one son this variable points to the one that is not null
	son_left_max = None			 # if the node to erase have 2 sons this variable points to the higher value node on the left..
								 # of the one to erase
	f_sup = None
	sup = abb
	while sup is not None and sup.key != key:  # iteration ultil we reach the key to erase or null
		f_sup = sup
		if key < sup.key:
			sup = sup.left
		else:
			sup = sup.right
				
	if sup is not None:
		sons_num = 0
		if sup.left != None:             # check the number of sons of the node to erase
			sons_num = sons_num + 1
		if sup.right != None:
			sons_num = sons_num + 1
				
		if sons_num == 0:                # if it has 0 sons we point the father to null
			if f_sup == None:
				abb = None
			elif f_sup.left == sup:
				f_sup.left = None
			else:
				f_sup.right = None
					
		elif sons_num == 1:           # when the node to erase have one son
			if sup.left == None:      # check which is the not empty son
				not_empty_son = sup.right
			else:	
				not_empty_son = sup.left
				
			if f_sup == None:                # if the sup node have father--
				abb = not_empty_son
			elif f_sup.left == sup:          # put the not empty son in the right position in father
				f_sup.left = not_empty_son
			else:
				f_sup.right = not_empty_son
				
		else:								 # when it have 2 sons
			f_sup = sup
			son_left_max = sup.left
			while son_left_max.right != None:  # search the max value node of the left tree of sup
				f_sup = son_left_max
				son_left_max = son_left_max.right
				
			sup.key = son_left_max.key         # change the max key of the left with the one in the node to erase
			if f_sup == sup:
				f_sup.left = son_left_max.left # assign father to the lasting tree
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