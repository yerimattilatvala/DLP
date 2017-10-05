
function createNode (key)
    local aux = {}
    if aux == nil then
        -- body
    end
    aux.key = key
    return aux
end 

function emptyTree (abb)
    return nil
end

function insert_r (abb,key)
    if abb == nil then -- if abb is an empty tree we only need to put a new Node inside
		return createNode(key)
	else
		if key < abb.key then -- if the key to insert is lower than the one in abb we call the same function with his left tree
			abb.left = insert_r(abb.left,key)
		elseif key > abb.key then -- if it is higher we call it with the right one
			abb.right = insert_r(abb.right,key)
		end
	end
	return abb
end

function insert_i (abb,key)
    local new_node = createNode(key) -- creation of a node containing the key to insert
	
	if abb == nil then
		return new_node	-- if abb is an empty tree we only need to put a new Node inside		
	else 
		local son = abb -- creation of variables 'son' an 'father' to iterate over the nodes of the tree
		local father = None
		while son ~= nil and son.key ~= key do 	-- the iteration takes place until 'son' is null or...
			father = son					   	-- the key to insert is the same as the one in 'son'...
			if key < son.key then			   	-- in each iteration 'son' points to his left or right...
				son = son.left					-- son depending of the value of the key to insert...
			else 								-- and father points to the previous value of 'son'
				son = son.right
			end
		end

		if son == nil then 				-- if 'son' is null we insert the 'new_node' in the 'son' position...
			if key < father.key then	-- but we do not know if 'son' is the right or left son of 'father'.. 
				father.left = new_node	-- so we check the key to insert against the key of 'father' to decide
			else 
				father.right = new_node
			end
		end								-- if 'son' is not null the key is already on the tree so there is nothing to do
		return abb
	end
end

function insertKey (abb,key)
	return insert_r(abb,key)
end

function search_r(abb,key)
	if abb == nil then	-- if the tree is empty the key can not be in it
		return None
	elseif abb.key == key then -- if the current node has the key we just return it
		return abb
	elseif key < abb.key then 			-- in other case we call the same function over the right...
		return search_r(abb.left,key)	-- or left son of the current node depending of the key
	else
		return search_r(abb.right,key)
	end
end

function search_i(abb,key)
	local node = abb	-- creation of the variable 'node' to iterate over the nodes of abb
	while node ~= nil and node.key ~= key do
		if key < node.key then	-- we iterate over 'node' until we get the node with the searched key o null
			node = node.left
		else
			node = node.right
		end
	end
	return node
end

function searchKey(abb,key)
	return search_i(abb,key)
end

function leftSon(abb)
	return abb.left
end

function rightSon(abb)
	return abb.right
end

function key(abb)
	return abb.key
end

function isEmptyTree(abb)
	return abb == nil
end

function erase_r(abb,key)
	local aux = nil 	-- contains abb when the sup2 function is called

	function sup2(tree)						-- puts in the key of 'aux' the higher key of the left tree of abb
		if tree.right ~= nil then
			tree.right = sup2(tree.right)
		else
			aux.key = tree.key
			return tree.left
		end
		return aux
	end

	if abb ~= nil then -- if abb is null we have nothing to do
		if key < abb.key then					-- if the key to erase is not the same as the one in the current node...
			abb.left = erase_r(abb.left,key)	-- we call erase_r over the left or right son of the current node
		elseif key > abb.key then
			abb.right = erase_r(abb.right,key)
		else									-- if the key of the node is the same as the one to erase..
			aux = abb							-- we erase it and asign abb to the rest of the tree 
			if abb.left == nil then
				abb = abb.right
			elseif abb.right == nil then
				abb = abb.left
			else
				abb = sup2(abb.left)			-- if the node have 2 sons we call sup2 
			end
			aux = None
		end
	end
	return abb
end

function erase_i(abb,key)
	local sons_num = nil		-- the number of sons of the node to erase
	local sup = nil				-- node to erase
	local f_sup = nil			-- father of the node to erase
	local not_empty_son = nil	-- if the node to erase only have one son this variable points to the one that is not null
	local son_left_max = nil	-- if the node to erase have 2 sons this variable points to the higher value node on the left..
								-- of the one to erase
	f_sup = nil
	sup = abb
	while sup ~= nil and sup.key ~= key do -- iteration ultil we reach the key to erase or null
		f_sup = sup
		if key < sup.key then
			sup = sup.left
		else
			sup = sup.right
		end
	end		

	if sup ~= nil then
		sons_num = 0
		if sup.left ~= None then		-- check the number of sons of the node to erase
			sons_num = sons_num + 1
		end
		if sup.right ~= None then
			sons_num = sons_num + 1
		end
				
		if sons_num == 0 then			-- if it has 0 sons we point the father to null
			if f_sup == None then
				abb = None
			elseif f_sup.left == sup then
				f_sup.left = None
			else
				f_sup.right = None
			end

		elseif sons_num == 1 then		-- when the node to erase hve one son
			if sup.left == None then		-- check which is the not empty son
				not_empty_son = sup.right
			else
				not_empty_son = sup.left
			end
				
			if f_sup == None then		-- if the sup node have father--
				abb = not_empty_son
			elseif f_sup.left == sup then	-- put the not empty son in the right position in father
				f_sup.left = not_empty_son
			else
				f_sup.right = not_empty_son
			end

		else				-- when it have 2 sons
			f_sup = sup
			son_left_max = sup.left
			while son_left_max.right ~= nil do  -- search the max value node of the left tree of sup
				f_sup = son_left_max
				son_left_max = son_left_max.right
			end

			sup.key = son_left_max.key 	--change the max key of the left with the one in the node to erase
			if f_sup == sup then
				f_sup.left = son_left_max.left	-- assign father to the lasting tree
			else
				f_sup.right = son_left_max.left 
			end

			sup = son_left_max
		end

		sup = None
	end	
	return abb
end

function eraseKey(abb,key)
	return erase_i(abb,key)
end