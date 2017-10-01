let rec preorderWithBracket abb = 
    print_string "(";
    if not (isEmptyTree abb ) then
        if not (isEmptyTree !(leftSon abb)) || not (isEmptyTree !(rightSon abb)) then
            begin
                print_string " ";
                print_int (key abb);
                print_string " ";
                preorderWithBracket !(leftSon abb);
                print_string " ";
                preorderWithBracket !(rightSon abb);

            end
        else begin
            print_string " ";
            print_int (key abb);
            print_string " ";

        end;
        print_string ")";;

let test i = match i with
    0->()
    |1->
        let abb = ref emptyTree in
        insertKey abb 4;
        insertKey abb 4;
        insertKey abb 2;
        insertKey abb 6;
        insertKey abb 1;
        insertKey abb 3;
        insertKey abb 5;
        insertKey abb 7;


        preorderWithBracket !abb;
        print_string "\n";

        print_string " Buscar 1... ";
        print_int (key(searchKey abb 1));
        print_string "\n";

        print_string " Buscar 2... ";
        print_int (key(searchKey abb 2));
        print_string "\n";

        print_string " Buscar 3... ";
        print_int (key(searchKey abb 3));
        print_string "\n";

        print_string " Buscar 4... ";
        print_int (key(searchKey abb 4));
        print_string "\n";

        print_string " Buscar 5... ";
        print_int (key(searchKey abb 5));
        print_string "\n";

        print_string " Buscar 6... ";
        print_int (key(searchKey abb 6));
        print_string "\n";

        print_string " Buscar 7... ";
        print_int (key(searchKey abb 7));
        print_string "\n";

        print_string "remove 5...";
        eraseKey abb 5;
        preorderWithBracket !abb;
        print_string "\n";

        print_string "remove 6...";
        eraseKey abb 6;
        preorderWithBracket !abb;
        print_string "\n";

        print_string "remove 4...";
        eraseKey abb 4;
        preorderWithBracket !abb;
        print_string "\n";

        print_string "remove 2...";
        eraseKey abb 2;
        preorderWithBracket !abb;
        print_string "\n";
        ();;
