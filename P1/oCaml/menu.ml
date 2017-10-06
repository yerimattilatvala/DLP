(*
***** Autor1: Yeray Méndez Romero
***** Login1: yeray.mendez
***** Email1: yeray.mendez@udc.es
***** Autor2: Daniel Rivera López
***** Login2: d.rivera1
***** Email2: d.rivera1@udc.es
*)

open TAD (*Import TAD operations .*)
open Abb_program (*Import preorderWithBracket function and the test.*)

(*****************Menu*****************)
let menu  exit= 
  print_string("\n*******************************************");
  print_string("\nWelcome to ABB's menu of operations");
  print_string("\n*******************************************\n");
  print_string("\n-------------------------------------------\n");
  let abb = ref emptyTree in
  let rec submenu abb1  exit1 = 
    if exit1 = false then begin
      print_string "\n";
      print_string("Press 1 if you want to insert a number.");
      print_string("\nPress 2 if you want to delete a value ");
      print_string("from the tree.");
      print_string("\nPress 3 if you want to find a value in ");
      print_string("the tree, showing the corresponding subtree");
      print_string("per screen.");
      print_string("\nPress 4 if you want to display the tree by");
      print_string("screen in parenthesized format.");
      print_string("\nPress 5 if you want to run the default test.\n");
      print_string("\nPress 0 if you want to exit the menu\n");
      print_string("\n-------------------------------------------\n");
      print_string("\nWhat would you like to do?\n");
      try
        let choice = read_int () in
        if choice == 1 then begin
          print_string("\nInsert a number: ");
          let number = read_int () in
          insertKey abb1 number; 
          print_string "\n";
          submenu abb1 false
        end
        else if choice == 2 then begin
          print_string("\nInsert a number that you want to the delete: ");
          let number = read_int () in
          eraseKey abb1 number;
          print_string "\n";
          submenu abb1 false
        end
        else if choice == 3 then begin
          preorderWithBracket !abb1;
          print_string "\n";
          print_string("\nInsert a number that you want to search: ");
          let number = read_int () in
          let root = key(searchKey abb1 number) in
          print_string "\n This is the number : ";
          print_int root;
          print_string "\n";
          submenu abb1 false
        end
        else if choice == 4 then begin
          preorderWithBracket !abb1;
          print_string "\n";
          submenu abb1 false
        end
        else if choice == 5 then begin
          test 1;
          print_string "\n";
          submenu abb1 false
        end
        else if choice = 0 then
          submenu abb1 true
        else begin
          print_string "\nYour choice is not correct, try again.\n ";
          submenu abb1 false
        end
        with 
          Failure ("int_of_string")->
            print_string("\nError,do not enter a letter, try again.\n");
            submenu abb1 false
          |Match_failure("TAD.ml", 28, 14) ->
            print_string("The number is not on the tree. \n");
            submenu abb1 false
          
      end
      else print_string("\n-------------------------------------------\n");
  in submenu abb exit;;

  menu(false);;

