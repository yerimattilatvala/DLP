/*
---Como compilar:
--- groovyc ./TAD.groovy
--- groovyc ./abb_program.groovy
--- groovy ./menu.groovy
*/
tad = new TAD()
test = new abb_program()

def menu(){

    //if (see==1)
      //  test(1)
   // else
    println '*******************************************'
	println 'Welcome to ABBs menu of operations'
	println '*******************************************' 
	println '-------------------------------------------'
	def exit =  0
	//abb = emptyTree(None)

	while (exit == 0){
		print "Press 1 if you want to insert a number."
		print "\nPress 2 if you want to delete a value "
		print "from the tree." 
		print "\nPress 3 if you want to find a value in "
		print "the tree, showing the corresponding subtree"
		print "per screen."
		print "\nPress 4 if you want to display the tree by"
		print "screen in parenthesized format."
		print "\nPress 0 if you want to exit the menu"

        
        println '\n-------------------------------------------'
        def choice =System.console().readLine 'What is your choice?\n'
        choice = choice.toInteger()       
        println '-------------------------------------------'

        switch(choice) {
            case 0:
                exit =1
                println '-------------------------------------------'
                break
            case 1://insert
                break
            case 2://erase
                break
            case 3://search
                break
            case 4://preorderWithBracket
                break
            case 5://test
                test.test()
                break
        }
		
    }

}
 menu()