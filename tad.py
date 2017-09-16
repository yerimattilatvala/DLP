class Node:
	def createNode(self, key =None, left =None, right =None):
		self.key = key
		self.left = left
		self.right = right

	def emptyTRee(self):
		self.key = None

#--------------------------------------------------------------·#


#------------------------ Recursive Insert----------------------#
	def insert_r(self,key):
		if self.key == None:
			createNode(self,key)
		else :
			if key < self.key:
				insert_r(self.left,key)
			else if key > self.key : 
				insert_r(self.right,key)


	def insert_i(self,key):
		newNode = Node ()
		createNode(newNode,key)
		if self.key == None:
			self.key = newNode.key
			self.left = newNode.left
			self.right = newNode.right			
		else :
			if newNode.key < self.key :
				son = self
				father = Node ()
				while son.key != None && son.key != key:
					father = son
					if key < son.key :
						son = son.left
					else :
						son = son.right

				if son.key = None :
					if key < father.key :
						father.left = newNode
					else :
						father.right = newNode
