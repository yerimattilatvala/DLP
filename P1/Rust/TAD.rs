type Link = Option<Box<Node>>;

struct Node{
    root: i32,
    left: Link,
    right: Link,
}

fn createNodeA(key: i32)-> Link{
    Some(Box::new(Node{root:key, left:None, right:None}))
}

fn emptyTree() -> Link {
    return None;
}

fn insert_r(mut abb: Link, key:i32)->Link{
    match abb {
        Some(ref abb) =>{ if key < abb.root {
            insert_r(abb.left,key)
        } else if key > abb.root{
            insert_r(abb.right,key)
        }else{
            
        }},
        None => createNodeA(key),
    }
}

fn key(abb:Link)-> i32{
    match abb {
        Some(ref abb) => abb.root,
        None => panic!("ERROR: EmptyTree"),
    }
}
//fn emptyTree()->

fn main(){
    let mut abb = emptyTree();
    abb = insert_r(abb,4);
    println!("{}",key(abb));
}