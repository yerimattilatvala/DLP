open Format

module Error = struct

exception Exit of int

type info = FI of string * int * int | UNKNOWN
type 'a withinfo = {i: info; v: 'a}

let dummyinfo = UNKNOWN
let createInfo f l c = FI(f, l, c)

(* Opens a new box, the function 'f' prints inside it and raises an 'Exit' exception with code '1'*)
let errf f = 
  (* print_flush(); Resets the pretty-printer to initial state, al pretty-printing boxes are closed and all pending text is printed *)
  print_flush(); 
  (*open_vbox 0;  Open a new vertical box with offset '0', break hints split the lines, when this happens '0' is added to the current identation *)
  open_vbox 0; 
  (*open_hvbox 0;  Open a new horizontal/vertical box with offset '0', it does not splits lines if they fit on the current printing line
      , but if they does not fit, it behaves like a vertical box*) 
  (*print_cut();  Outputs a simple break hint *)
  open_hvbox 0; f(); print_cut(); close_box(); print_newline();
  raise (Exit 1)

(* Receives an 'info' type and prints its line and character if possible *)
let printInfo =
  (* In the text of the book, file positions in error messages are replaced
     with the string "Error:" *)
  function
    FI(f,l,c) ->
      print_string f; 
      print_string ":"; 
      print_int l; print_string "."; 
      print_int c; print_string ":"
  | UNKNOWN ->
      print_string "<Unknown file and line>: "

(* Calls 'errf' with a function that print the line an character information and executes the function 'f' *)
let errfAt fi f = errf(fun()-> printInfo fi; print_space(); f())

(* Calls 'errf' with a function that prints a error with the string 's' *)
let err s = errf (fun()-> print_string "Error: "; print_string s; print_newline())

(* Calls 'errfAt' with a function to print the string s *)
let error fi s = errfAt fi (fun()-> print_string s; print_newline())

(* Prints a warning with the given string 's' *)
let warning s =
  print_string "Warning: "; print_string s;
  print_newline()

(* Prints a warning with the given string 's' and the line and position where it happened *)
let warningAt fi s =
  printInfo fi; print_string " Warning: ";
  print_string s; print_newline()

end

(* ---------------------------------------------------------------------- *)

module Pervasive = struct

type info = Error.info

(* Prints a string in the current pretty-printing box *)
let pr = Format.print_string

end (* module pervasive *)


