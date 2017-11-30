(* Module Main: The main program.  Deals with processing the command
   line, reading files, building and connecting lexers and parsers, etc. 
   
   For most experiments with the implementation, it should not be
   necessary to change this file.
*)

open Format
open Support.Pervasive
open Support.Error
open Syntax
open Core

let searchpath = ref [""]

let argDefs = [
  "-I",
      Arg.String (fun f -> searchpath := f::!searchpath),
      "Append a directory to the search path"]

let parseArgs () =                                                  (*Function that examine the input arguments*)
  let inFile = ref (None : string option) in
  Arg.parse argDefs
     (fun s ->
       match !inFile with
         Some(_) -> err "You must specify exactly one input file";  (*Return this error if will pass two or more input arguments*)
       | None -> inFile := Some(s))
     "";
  match !inFile with
      (*None -> err "You must specify an input file" *)             (*Modify this line that allow start iterative mode*)
      None -> 
        print_string("You not specify an input file\n"); 
        print_string("Starting iterative mode ...\n"); 
        "Empty"
  | Some(s) -> s                                                    (*Return test.f*)

let openfile infile =                                               (*Open the file*)
  let rec trynext l = match l with
        [] -> err ("Could not find " ^ infile)
      | (d::rest) -> 
          let name = if d = "" then infile else (d ^ "/" ^ infile) in
          try open_in name                                            (*open_in : string -> in_channel =<fun>*)
            with Sys_error m -> trynext rest
  in trynext !searchpath

let parseFile inFile line= match inFile with
  ""->
    let lexbuf = Lexing.from_string line 
    in let result =
    try Parser.toplevel Lexer.main lexbuf with Parsing.Parse_error -> 
    error (Lexer.info lexbuf) "Parse error"
    in
      Parsing.clear_parser(); result
  |_->
  let pi = openfile inFile
  in let lexbuf = Lexer.create inFile pi
  in let result =
    try Parser.toplevel Lexer.main lexbuf with Parsing.Parse_error -> 
    error (Lexer.info lexbuf) "Parse error"
in
  Parsing.clear_parser(); close_in pi; result

let alreadyImported = ref ([] : string list)

let rec process_command ctx cmd = match cmd with
  | Eval(fi,t) -> 
      let t' = eval ctx t in
      printtm_ATerm true ctx t'; 
      force_newline();
      ctx
  | Bind(fi,x,bind) -> 
      
      let bind' = evalbinding ctx bind in
      pr x; pr " "; prbinding ctx bind'; force_newline();
      addbinding ctx x bind'
  
let process_file f ctx =
  alreadyImported := f :: !alreadyImported;
  let cmds,_ = parseFile f "" ctx in
  let g ctx c =  
    open_hvbox 0;
    let results = process_command ctx c in
    print_flush();
    results
  in
    List.fold_left g ctx cmds

let shell value ctx=
  print_string("\n*******************************************");
  print_string("\nWelcome to Iterative Mode");
  print_string("\n*******************************************\n");
  print_string("\n-------------------------------------------\n");
  print_string("Choose option:\n");
  print_string("Write a expresion to load.\n");
  print_string("Exit if you go out of iterative mode.\n");
  let rec shell_aux value ctx2= 
    let ctx_aux = ref ctx2 in
  if value = false then begin
    print_newline();
    let line = read_line() in
    match line with
    "exit"->
      shell_aux true ctx2
    |line->
      let cmds,_ = parseFile "" line ctx2 in
      let g ctx c =  
        open_hvbox 0;
        let results = process_command ctx2 c in
        print_flush();
        ctx_aux := results;
        results
      in
        List.fold_left g ctx2 cmds;
      print_string("\n-------------------------------------------\n");     
      shell_aux false !ctx_aux
  end
  else
    print_string("Go out of iterative mode....\n");
  in shell_aux value ctx;;

let main () =                                 (*Modify here*)
  let inFile = parseArgs() in
  match inFile with
  "Empty"->
    shell false emptycontext
  |"test.f"->
      let _ = process_file inFile emptycontext in
      ()
      let () = set_max_boxes 1000
      let () = set_margin 67;;
      let res = 
        Printexc.catch (fun () -> 
          try main();0 
          with Exit x -> x) 
      ()
      let () = print_flush()
      let () = exit res