type intabb = 
    Empty 
    | Node of int * intabb * intabb;;

let error s = 
    print_endline s;
    exit(0);;

let emptyTree = Empty;;

let rec insert_r abb data =  match abb with
    Empty -> Node(data,Empty,Empty)
    |Node(key,left,right) -> 
        if data < key then Node(key,insert_r left data, right)
        else if data>key then Node(key,left,insert_r right data)
        else abb;;

let insert_i abb data = 
    let newNode = Node(data,Empty,Empty) in
    if abb = Empty then
        newNode
    else begin
        let father = ref Empty in
        let son = ref abb in
        while !son != Empty && (key !son) != data do
            father := !son;
            if data < (key !son) then
                son := (leftSon !son)
            else
                son:=(rightSon !son)
        done;
        if !son = Empty then
            if data < key !father then 
                (*padre^.izdo := nuevo*)
            else 
                (*padre^.dcho := nuevo;*)
        else
            abb
end;;


let insertKey abb data = insert_r abb data;;

let rec search_r abb data = match abb with
    Empty -> Empty
    |Node(k,left,right) ->
        if data < k then search_r left data
        else if data > k then search_r right data
        else abb;;            
let searchKey abb data = search_r abb data;;

let isEmptyTree abb = match abb with
    Empty -> true
    |Node(_,_,_) -> false;;

let key abb = match abb with
    Node(key,_,_) -> key ;;

let leftSon abb = match abb with
    Empty -> Empty
    |Node(_,left,_) -> left;;

let rightSon abb = match abb with
    Empty -> Empty
    |Node(_,_,right) -> right;;

    