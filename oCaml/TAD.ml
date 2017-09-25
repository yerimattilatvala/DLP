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

let search_i abb data =
    let node = ref abb in
    while !node != Empty && (key !node) != data do
        if data < (key !node) then
            node := (leftSon !node)
        else
            node := (rightSon !node)
    done;
    !node;;

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

    let rec erase_r abb data = 
        
                let rec sup2 tree = match tree with
                    Node(k,l,r) -> 
                        if r != Empty then let (a,b) = sup2 r in
                            (a,Node(k,l,b))
                        else
                            (k,l)
        
                in
            match abb with
                Empty -> abb
                |Node(k,l,r) ->
                    if data < k then Node(k,erase_r l data,r)
                    else if data > k then Node(k,l,erase_r r data)
                    else match (l,r) with
                        (Empty,_) -> r
                        |(_,Empty) -> l 
                        |(_,_) -> let (a,b) = sup2 l in
                            Node(a,b,r);;

(*  Node(7,Node(3,Node(2,Empty,Empty),Node(5,Node(4,Empty,Empty),Node(6,Empty,Empty))),Node(8,Empty,Empty)) *)

(*let erase_i abb data = 
    let sons_num = ref 0 in
    let sup = ref (ref Empty) in
    let abb_out = ref (ref Empty) in
    let abb_out2 = ref (ref Empty) in
    let f_sup = ref (ref Empty) in
    let not_empty_son = ref (ref Empty) in
    let son_left_max = ref (ref Empty) in

    !abb_out := abb;
    abb_out2 := !abb_out;
    sup := !abb_out;
    while !(!sup) != Empty && (key !(!sup)) != data do
        f_sup := !sup;
        if data < (key !(!sup)) then
            sup := ref (leftSon !(!sup))
        else
            sup := ref (rightSon !(!sup))
    done;

    (if !(!sup) != Empty then
        (sons_num := 0;
        (if (leftSon !(!sup)) != Empty then
            sons_num := !sons_num + 1);
        (if (rightSon !(!sup)) != Empty then
            sons_num := !sons_num + 1);
            
        (if !sons_num == 0 then
            (if !(!f_sup) == Empty then
                !abb_out := Empty
            else if (leftSon !(!f_sup)) == !(!sup) then
                !f_sup := Node((key !(!f_sup)),Empty,(rightSon !(!f_sup)))
            else 
                !f_sup := Node((key !(!f_sup)),(leftSon !(!f_sup)),Empty))

        else if !sons_num == 1 then
            ((if (leftSon !(!sup)) == Empty then
                !not_empty_son := (rightSon !(!sup))
            else
                !not_empty_son := (leftSon !(!sup)));

            (if !(!f_sup) == Empty then
				!abb_out := !(!not_empty_son)
            else if (leftSon !(!f_sup)) == !(!sup) then
                !f_sup := Node((key !(!f_sup)),!(!not_empty_son),(rightSon !(!f_sup)))
            else
                !f_sup := Node((key !(!f_sup)),(leftSon !(!f_sup)),!(!not_empty_son))))
        
        else
            (!f_sup := !(!sup);
            !son_left_max := (leftSon !(!sup));
            while (rightSon !(!son_left_max)) != Empty do
                !f_sup := !(!son_left_max);
                !son_left_max := (rightSon !(!son_left_max))
            done;

            !sup := Node((key !(!son_left_max)),(leftSon !(!sup)),(rightSon !(!sup)));
            (if  !(!f_sup) == !(!sup) then
                !f_sup := Node((key !(!f_sup)),(leftSon !(!son_left_max)),(rightSon !(!f_sup)))
            else
                !f_sup := Node((key !(!f_sup)),(leftSon !(!f_sup)),(leftSon !(!son_left_max))));
            
            !sup := !(!son_left_max))
        )
        ));    
        !(!abb_out2);;*)