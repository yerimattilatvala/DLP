let input_line_opt ic =
  try Some (input_line ic)
  with End_of_file -> None;;

let delete_lines filename start skip =
  if start < 1 || skip < 1 then
    invalid_arg "delete_lines";
  let tmp_file = filename ^ ".tmp" in
  let ic = open_in filename
  and oc = open_out tmp_file in
  let until = start + skip - 1 in
  let rec aux i =
    match input_line_opt ic with
    | Some line ->
        if i < start || i > until
        then (output_string oc line; output_char oc '\n');
        aux (succ i)
    | None ->
        close_in ic;
        close_out oc;
        Sys.remove filename;
        Sys.rename tmp_file filename
  in
  aux 1

let delete_lines filename =
  let tmp_file = filename ^ ".tmp" in
  let ic = open_in filename
  and oc = open_out tmp_file in
  match input_line_opt ic with
  | Some line ->
      if line !=""
      then (output_string oc line; output_char oc '\n');
       close_in ic;
      close_out oc;
      Sys.remove filename;
      Sys.rename tmp_file filename;
  | None ->
      close_in ic;
      close_out oc;
      Sys.remove filename;
      Sys.rename tmp_file filename;;
  

    
      let createAuxFile name contain=       (*creo un archivo de texto donde introduzco las expresiones del modo itertivo*)
      let oc = open_out name in           (*asi despues se pueden procesar como en un fichero que es lo que le pasan*)
      output_string oc contain;           (*hice sto porque cuando abres un fichero cada linea se pasa a un in_channel*)
      close_out oc;                       (*asi este puede ser procesado como en una ejecucion con un fichero*)
      name;;                              (*no encontre otra forma ya que no encontre un metodo que formatee string in_channel*)

      let run () =
        let b = Bytes.create 1024 in
        let stdin_fd = stdin in
        let stdout_fd = stdout in
        (read stdin_fd b 0 1024) >=
           (fun _  ->
              print_endline "done";
              print_endline b;
              print_endline "ok?";
              Lwt.return ())
