/*
***** Autor1: Yeray Méndez Romero
***** Login1: yeray.mendez
***** Email1: yeray.mendez@udc.es
***** Autor2: Daniel Rivera López
***** Login2: d.rivera1
***** Email2: d.rivera1@udc.es
*/

tad = new TAD() //Import TAD operations.
test = new abb_program() //Import preorderWithBracket function and the test.

/*****************Menu****************/

def menu(){

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
        print "\nPress 5 if you want to run the default test."
        print "\nPress 0 if you want to exit the menu."

        
        println '\n-------------------------------------------'
        def choice =System.console().readLine 'What is your choice?\n'
        try{
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
                    number = System.console().readLine'Insert a number that you want to the delete: '
                    number = number.toInteger() 
                    abb = tad.eraseKey(abb,number)
                    println '-------------------------------------------'
                    break
                case 3:
                    println '-------------------------------------------'
                    test.preorderWithBracket(abb)
                    print '\n'
                    number = System.console().readLine'Insert a number that you want to search:  '
                    number = number.toInteger() 
                    println 'search '+number+'...'+ tad.key(tad.searchKey(abb,number))
                    println '-------------------------------------------'
                    break
                case 4:
                    println '-------------------------------------------'
                    test.preorderWithBracket(abb)
                    println '\n-------------------------------------------'
                    break
                case 5:
                    println '-------------------------------------------'
                    test.test()
                    println '\n-------------------------------------------'
                    break
                default :
                    println '-------------------------------------------'
                    println 'Your choice is not correct, try again.'
                    println '-------------------------------------------'
                    break
            }
        }catch (Exception e) {
            println("\nError,do not enter a letter or search for a number that not is in the tree, try again.") //Catch error
            println ("--------------------------------------------")
        }
        
    }
}
 menu()