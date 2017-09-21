
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
    if abb == nil then
		return createNode(key)
	else
		if key < abb.key then
			abb.left = insert_r(abb.left,key)
		elseif key > abb.key then
			abb.right = insert_r(abb.right,key)
		end
	end
	return abb
end

function insert_i (abb,key)
    local new_node = createNode(key)
	
	if abb == nil then
		return new_node			
	else 
		local son = abb
		local father = None
		while son ~= nil and son.key ~= key do
			father = son
			if key < son.key then
				son = son.left
			else 
				son = son.right
			end
		end

		if son == nil then
			if key < father.key then
				father.left = new_node
			else 
				father.right = new_node
			end
		end
		return abb
	end
end

function insertKey (abb,key)
	return insert_r(abb,key)
end

function search_r(abb,key)
	if abb == nil then
		return None
	elseif abb.key == key then
		return abb
	elseif key < abb.key then
		return search_r(abb.left,key)
	else
		return search_r(abb.right,key)
	end
end

function search_i(abb,key)
	local node = abb
	while node ~= nil and node.key ~= key do
		if key < node.key then
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
	local aux = nil

	function sup2(tree)
		if tree.right ~= nil then
			tree.right = sup2(tree.right)
		else
			aux.key = tree.key
			--aux = tree
			return tree.left
		end
		return aux
	end

	if abb ~= nil then
		if key < abb.key then
			abb.left = erase_r(abb.left,key)
		elseif key > abb.key then
			abb.right = erase_r(abb.right,key)
		else
			aux = abb
			if abb.left == nil then
				abb = abb.right
			elseif abb.right == nil then
				abb = abb.left
			else
				abb = sup2(abb.left)
			end
			aux = None
		end
	end
	return abb
end

function erase_i(abb,key)
	local sons_num = nil
	local sup = nil
	local f_sup = nil
	local not_empty_son = nil
	local son_left_max = nil
		
	f_sup = nil
	sup = abb
	while sup ~= nil and sup.key ~= key do
		f_sup = sup
		if key < sup.key then
			sup = sup.left
		else
			sup = sup.right
		end
	end		

	if sup ~= nil then
		sons_num = 0
		if sup.left ~= None then
			sons_num = sons_num + 1
		end
		if sup.right ~= None then
			sons_num = sons_num + 1
		end
				
		if sons_num == 0 then
			if f_sup == None then
				abb = None
			elseif f_sup.left == sup then
				f_sup.left = None
			else
				f_sup.right = None
			end

		elseif sons_num == 1 then
			if sup.left == None then
				not_empty_son = sup.right
			else
				not_empty_son = sup.left
			end
				
			if f_sup == None then
				abb = not_empty_son
			elseif f_sup.left == sup then
				f_sup.left = not_empty_son
			else
				f_sup.right = not_empty_son
			end

		else
			f_sup = sup
			son_left_max = sup.left
			while son_left_max.right ~= nil do
				f_sup = son_left_max
				son_left_max = son_left_max.right
			end

			sup.key = son_left_max.key
			if f_sup == sup then
				f_sup.left = son_left_max.left
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