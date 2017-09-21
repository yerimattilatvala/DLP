local abbTad = require("TAD")
local abbTest = require("abb_program")

function menu()
	print('\n*******************************************')
	print("Welcome to ABB's menu of operations")
	print('*******************************************')
	print('\n-------------------------------------------')
	exit =  False
	local abb = emptyTree(None)

	while exit == False do
		choice = 0
		print("Press 1 if you want to insert a number.")
		print("\nPress 2 if you want to delete a value ")
		print("from the tree.")
		print("\nPress 3 if you want to find a value in ")
		print("the tree, showing the corresponding subtree")
		print("per screen.")
		print("\nPress 4 if you want to display the tree by")
		print("screen in parenthesized format.")
        print("\nPress 5 if you want to run the default test")
		print("\nPress 0 if you want to exit the menu")

		print('-------------------------------------------')
        print("\nWhat would you like to do?\n")
		choice = tonumber(io.read())
		print('\n-------------------------------------------')
         if choice == nil then
            print('-------------------------------------------')
			print("Your choice is not a number, try again.")
			print('-------------------------------------------\n')
		elseif choice == 0 then
			exit = True
			print('-------------------------------------------')
			break
		elseif choice == 1 then
			print('-------------------------------------------')
			print("\nInsert a number: ")
            number = tonumber(io.read())
            if number ~= nil then
			    abb = insertKey(abb,number)
			    print('\n-------------------------------------------')
            else 
			    print("Your choice is not a number, try again.")
			    print('-------------------------------------------\n')
            end
		elseif choice == 2 then
			print('-------------------------------------------')
			print("\nInsert a number: ")
            number = tonumber(io.read())
            if number ~= nil then
			    abb = eraseKey(abb,number)
			    print('\n-------------------------------------------')
            else 
			    print("Your choice is not a number, try again.")
			    print('-------------------------------------------\n')
            end
		elseif choice == 3 then
			print('-------------------------------------------')
			preorderWithBracket(abb)
			print("\nInsert a number that you want to search: ")
            number = tonumber(io.read())
            if number ~= nil then
			    print('Search',number,'...',key(searchKey(abb,number)))
			    print('\n-------------------------------------------')
            else 
			    print("Your choice is not a number, try again.")
			    print('-------------------------------------------\n')
            end
		elseif choice == 4 then
			print('-------------------------------------------')
			preorderWithBracket(abb)
			print('\n-------------------------------------------')
        elseif choice == 5 then
			print('-------------------------------------------')
			test()
			print('\n-------------------------------------------')
		else 
			print("The option is not in the menu, try again.")
			print('-------------------------------------------\n')
        end

	end	
end

menu()