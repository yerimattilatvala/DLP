(*
***** Autor1: Yeray Méndez Romero
***** Login1: yeray.mendez
***** Email1: yeray.mendez@udc.es
***** Autor2: Daniel Rivera López
***** Login2: d.rivera1
***** Email2: d.rivera1@udc.es
*)

type intabb = 
    Empty 
    | Node of int * intabb ref * intabb ref;;

let emptyTree = Empty;;

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

let rec insert_r abb data =  match !abb with
    Empty -> abb := Node(data,ref Empty,ref Empty)  (*if abb is an empty tree we only need to put a new Node inside*)
    |Node(key,left,right) -> 
        if data < key then insert_r left data  (* if the key to insert is lower than the one in abb we call the same function with his left tree*)
        else if data>key then insert_r right data;; (*if it is higher we call it with the right one*)

let insert_i abb data = 
    let newNode = Node(data,ref Empty,ref Empty) in (*creation of a node containing the key to insert*)
    let father = ref (ref emptyTree) in (*creation of variables 'son' an 'father' to iterate over the nodes of the tree*)
    let son = ref (ref emptyTree) in
    match !abb with
        Empty -> abb := newNode (*if abb is an empty tree we only need to put a new Node inside*)
        |Node(_,_,_)-> (
            !father := emptyTree;
            son := abb;
            while (!(!son) != Empty) && ((key !(!son)) != data) do  (*the iteration takes place until 'son' is null or...*)
                father := !son;                                     (*the key to insert is the same as the one in 'son'...*)
                (if data < (key !(!son)) then                       (*in each iteration 'son' points to his left or right...*)
                    son := leftSon(!(!son))                         (*son depending of the value of the key to insert...*)
                else                                                (*and father points to the previous value of 'son'*)
                    son := rightSon(!(!son)));
            done;
            (if !(!son) == Empty then                   (*if 'son' is null we insert the 'new_node' in the 'son' position...*)
                (if data < (key !(!father)) then        (*but we do not know if 'son' is the right or left son of 'father'.. *)
                    leftSon !(!father) := newNode       (*so we check the key to insert against the key of 'father' to decide*)
                else
                    rightSon !(!father) := newNode));
            ()                                          
            );;                                         (*if 'son' is not null the key is already on the tree so there is nothing to do*)

let insertKey abb data = insert_r abb data;;

let rec search_r abb data = match !abb with
    Empty -> Empty  (*if the tree is empty the key can not be in it*)
    |Node(k,left,right) ->
        if data < k then search_r left data (*in other case we call the same function over the right...*)
        else if data > k then search_r right data (*or left son of the current node depending of the key+*)
        else !abb;; (*if the current node has the key we just return it*)

let search_i abb data =
    let node = ref !abb in      (*creation of the variable 'node' to iterate over the nodes of abb*)
    while !node != Empty && (key !node) != data do
        if data < (key !node) then  (*we iterate over 'node' until we get the node with the searched key o null*)
            node := !(leftSon !node)
        else
            node := !(rightSon !node)
    done;
    !node;;

let searchKey abb data = search_r abb data;;

let rec erase_r abb data = 
    let aux = ref abb in    (*contains abb when the sup2 function is called*)
        let rec sup2 tree = match !tree with    (*puts in the key of 'aux' the higher key of the left tree of abb*)
            Node(k,l,r) -> 
                (if !r != Empty then sup2 r
                else (
                    !aux := Node(k,leftSon !(!aux),rightSon !(!aux));
                    tree := !(leftSon !tree);
                )
                );()

        in
    match !abb with
        Empty -> ()     (*if abb is null we have nothing to do*)
        |Node(k,l,r) ->
            if data < k then erase_r l data         (*if the key to erase is not the same as the one in the current node..*)
            else if data > k then erase_r r data    (*we call erase_r over the left or right son of the current node*)
            else match (!l,!r) with                 (*if the key of the node is the same as the one to erase..*)
                (Empty,_) -> abb := !r              (*we erase it and asign abb to the rest of the tree *)
                |(_,Empty) -> abb := !l 
                |(_,_) -> sup2 l;;      (*if the node have 2 sons we call sup2 *)

let erase_i abb data = 
    let sons_num = ref 0 in                 (*the number of sons of the node to erase*)
    let sup = ref (ref Empty) in            (*node to erase*)
    let f_sup = ref (ref Empty) in          (*father of the node to erase*)
    let not_empty_son = ref (ref Empty) in  (*if the node to erase only have one son this variable points to the one that is not null*)
    let son_left_max = ref (ref Empty) in   (*if the node to erase have 2 sons this variable points to the higher value node on the left..*)
                                            (*of the one to erase
	f_sup = nil*)
    sup := abb;
    while !(!sup) != Empty && (key !(!sup)) != data do  (*iteration ultil we reach the key to erase or null*)
        f_sup := !sup;
        if data < (key !(!sup)) then
            sup := leftSon !(!sup)
        else
            sup := rightSon !(!sup)
    done;

    (if !(!sup) != Empty then
        (sons_num := 0;
        (if !(leftSon !(!sup)) != Empty then                (*check the number of sons of the node to erase*)
            sons_num := !sons_num + 1);
        (if !(rightSon !(!sup)) != Empty then
            sons_num := !sons_num + 1);
            
        (if !sons_num == 0 then                             (*if it has 0 sons we point the father to null*)
            (if !(!f_sup) == Empty then
                abb := Empty
            else if !(leftSon !(!f_sup)) == !(!sup) then
                (leftSon !(!f_sup)) := Empty
            else 
                (rightSon !(!f_sup)) := Empty)

        else if !sons_num == 1 then                         (*when the node to erase have one son*)
            ((if !(leftSon !(!sup)) == Empty then           (*check which is the not empty son*)
                not_empty_son := (rightSon !(!sup))
            else
                not_empty_son := (leftSon !(!sup)));

            (if !(!f_sup) == Empty then                     (*if the sup node have father--*)
				abb := !(!not_empty_son)
            else if !(leftSon !(!f_sup)) == !(!sup) then    (*put the not empty son in the right position in father*)
                (leftSon !(!f_sup)) := !(!not_empty_son)
            else
                (rightSon !(!f_sup)) := !(!not_empty_son)))
        
        else          (*when it have 2 sons*)
            (f_sup := !sup;
            son_left_max := (leftSon !(!sup));
            while !(rightSon !(!son_left_max)) != Empty do  (*search the max value node of the left tree of sup*)
                f_sup := !son_left_max;
                son_left_max := (rightSon !(!son_left_max))
            done;

            !sup := Node((key !(!son_left_max)),(leftSon !(!sup)),(rightSon !(!sup)));  (*change the max key of the left with the one in the node to erase*)
            (if  !(!f_sup) == !(!sup) then
                (leftSon !(!f_sup)) := !(leftSon !(!son_left_max))      (*assign father to the lasting tree*)
            else
                (rightSon !(!f_sup)) := !(leftSon !(!son_left_max)));
            
            sup := !son_left_max
            )
        )
        ));
        ();;

let eraseKey abb data = erase_i abb data;;