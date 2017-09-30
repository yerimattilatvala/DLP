type intabb = 
    Empty 
    | Node of int * intabb ref * intabb ref;;

let error s = 
    print_endline s;
    exit(0);;

let emptyTree = Empty;;

let rec insert_r abb data =  match !abb with
    Empty -> abb := Node(data,ref Empty,ref Empty)
    |Node(key,left,right) -> 
        if data < key then insert_r left data
        else if data>key then insert_r right data;;

let insert_i abb data = 
    let newNode = Node(data,ref Empty,ref Empty) in
    let father = ref (ref emptyTree) in
    let son = ref (ref emptyTree) in
    match !abb with
        Empty -> abb := newNode
        |Node(_,_,_)-> (
            !father := emptyTree;
            son := abb;
            while (!(!son) != Empty) && ((key !(!son)) != data) do
                father := !son;
                (if data < (key !(!son)) then
                    son := leftSon(!(!son))
                else
                    son := rightSon(!(!son)));
            done;
            (if !(!son) == Empty then
                (if data < (key !(!father)) then
                    leftSon !(!father) := newNode
                else
                    rightSon !(!father) := newNode));
            ()
            );;



let rec search_r abb data = match !abb with
    Empty -> Empty
    |Node(k,left,right) ->
        if data < k then search_r left data
        else if data > k then search_r right data
        else !abb;; 

let search_i abb data =
    let node = ref !abb in
    while !node != Empty && (key !node) != data do
        if data < (key !node) then
            nodelet insertKey abb data = insert_r abb data;; := !(leftSon !node)
        else
            node := !(rightSon !node)
    done;
    !node;;

let searchKey abb data = search_r abb data;;

let isEmptyTree abb = match abb with
    Empty -> true
    |Node(_,_,_) -> false;;

let key abb = match abb with
    |Node(key,_,_) -> key ;;

let leftSon abb = match abb with
    Empty -> ref Empty
    |Node(_,left,_) -> left;;

let rightSon abb = match abb with
    Empty -> ref Empty
    |Node(_,_,right) -> right;;

let rec erase_r abb data = 
    let aux = ref abb in
        let rec sup2 tree = match !tree with
            Node(k,l,r) -> 
                (if !r != Empty then sup2 r
                else (
                    !aux := Node(k,leftSon !(!aux),rightSon !(!aux));
                    tree := !(leftSon !tree);
                )
                );()

        in
    match !abb with
        Empty -> ()
        |Node(k,l,r) ->
            if data < k then erase_r l data
            else if data > k then erase_r r data
            else match (!l,!r) with
                (Empty,_) -> abb := !r
                |(_,Empty) -> abb := !l 
                |(_,_) -> sup2 l;;
                

let erase_i abb data = 
    let sons_num = ref 0 in
    let sup = ref (ref Empty) in
    let f_sup = ref (ref Empty) in
    let not_empty_son = ref (ref Empty) in
    let son_left_max = ref (ref Empty) in

    sup := abb;
    while !(!sup) != Empty && (key !(!sup)) != data do
        f_sup := !sup;
        if data < (key !(!sup)) then
            sup := leftSon !(!sup)
        else
            sup := rightSon !(!sup)
    done;

    (if !(!sup) != Empty then
        (sons_num := 0;
        (if !(leftSon !(!sup)) != Empty then
            sons_num := !sons_num + 1);
        (if !(rightSon !(!sup)) != Empty then
            sons_num := !sons_num + 1);
            
        (if !sons_num == 0 then
            (if !(!f_sup) == Empty then
                abb := Empty
            else if !(leftSon !(!f_sup)) == !(!sup) then
                (leftSon !(!f_sup)) := Empty
            else 
                (rightSon !(!f_sup)) := Empty)

        else if !sons_num == 1 then
            ((if !(leftSon !(!sup)) == Empty then
                not_empty_son := (rightSon !(!sup))
            else
                not_empty_son := (leftSon !(!sup)));

            (if !(!f_sup) == Empty then
				abb := !(!not_empty_son)
            else if !(leftSon !(!f_sup)) == !(!sup) then
                (leftSon !(!f_sup)) := !(!not_empty_son)
            else
                (rightSon !(!f_sup)) := !(!not_empty_son)))
        
        else
            (f_sup := !sup;
            son_left_max := (leftSon !(!sup));
            while !(rightSon !(!son_left_max)) != Empty do
                f_sup := !son_left_max;
                son_left_max := (rightSon !(!son_left_max))
            done;

            !sup := Node((key !(!son_left_max)),(leftSon !(!sup)),(rightSon !(!sup)));
            (if  !(!f_sup) == !(!sup) then
                (leftSon !(!f_sup)) := !(leftSon !(!son_left_max))
            else
                (rightSon !(!f_sup)) := !(leftSon !(!son_left_max)));
            
            sup := !son_left_max
            )
        )
        ));
        ();;

let eraseKey abb data = erase_i abb data;;