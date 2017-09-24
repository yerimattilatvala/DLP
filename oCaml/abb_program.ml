

let rec preorderWithBracket abb = 
  print_string "(";
  if not (isEmptyTree abb ) then
      if not (isEmptyTree (leftSon abb)) || not (isEmptyTree (rightSon abb)) then
          begin
              print_string " ";
              print_int (key abb);
              print_string " ";
              preorderWithBracket (leftSon abb);
              print_string " ";
              preorderWithBracket (rightSon abb);
              print_string ")";
          end
      else begin
          print_string " ";
          print_int (key abb);
          print_string " ";
          print_string ")";
      end
    else print_string ")";;


let abb = emptyTree;;
let abb = insertKey abb 4;;
let abb = insertKey abb 4;;
let abb = insertKey abb 2;;
let abb = insertKey abb 6;;
let abb = insertKey abb 1;;
let abb = insertKey abb 3;;
let abb = insertKey abb 5;;
let abb = insertKey abb 7;;


preorderWithBracket abb;;

print_string " Buscar 1... ";;
print_int (key(searchKey abb 1));;
print_string "\n";;

print_string " Buscar 2... ";;
print_int (key(searchKey abb 2));;
print_string "\n";;

print_string " Buscar3... ";;
print_int (key(searchKey abb 3));;
print_string "\n";;

print_string " Buscar 4... ";;
print_int (key(searchKey abb 4));;
print_string "\n";;

print_string " Buscar 5... ";;
print_int (key(searchKey abb 5));;
print_string "\n";;

print_string " Buscar 6... ";;
print_int (key(searchKey abb 6));;
print_string "\n";;

print_string " Buscar 7... ";;
print_int (key(searchKey abb 7));;
print_string "\n";;
