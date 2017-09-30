/*
---Como compilar:
--- groovyc ./TAD.groovy
--- groovyc ./abb_program.groovy
--- groovy ./menu.groovy
*/
tad = new TAD()
test = new abb_program()

def menu(see){

    if (see==1)
        test.test()
   else{
        println '*******************************************'
        println 'Welcome to ABBs menu of operations'
        println '*******************************************' 
        println '-------------------------------------------'
        def exit =  0
        def abb = tad.emptyTree(null)
        def number = null

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
                case 1:
                    println '-------------------------------------------'
				    number = System.console().readLine'Insert a number: '
                    number = number.toInteger()
				    abb = tad.insertKey(abb,number)
				    println '-------------------------------------------'
                    break
                case 2:
                    println '-------------------------------------------'
				    number = System.console().readLine'Insert a number: '
                    number = number.toInteger()
				    abb = tad.eraseKey(abb,number)
				    println '-------------------------------------------'
                    break
                case 3:
                    println '-------------------------------------------'
                    test.preorderWithBracket(abb)
                    print '\n'
				    number = System.console().readLine'Insert a number: '
                    number = number.toInteger()
				    println 'search '+number+'...'+ tad.key(tad.searchKey(abb,number))
				    println '-------------------------------------------'
                    break
                case 4:
                    println '-------------------------------------------'
                    test.preorderWithBracket(abb)
                    println '\n-------------------------------------------'
                    break
                default :
                    println '-------------------------------------------'
                    println 'Your choice is not correct, try again.'
                    println '-------------------------------------------'
                    break
            }
            
        }
    }
}
 menu(0)