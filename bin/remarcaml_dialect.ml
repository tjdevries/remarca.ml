open Base

let args = Sys.get_argv () |> Array.to_list

let () =
  (* Fmt.pr "let x = 10\n"; *)
  (* Fmt.pr "(*\n"; *)
  (* List.iter args ~f:(Fmt.pr "%s\n"); *)
  (* Fmt.pr "*)\n"; *)
  let filename = List.nth_exn args 1 in
  let contents = Bos.OS.File.read (Fpath.v filename) in
  let contents =
    match contents with
    | Ok contents ->
      Fmt.str
        "let node1 = Remarcaml.Nodes.new_text {|%s|} |> Remarcaml.Nodes.Builtin.italic \n"
        (String.strip contents)
    | _ -> assert false
  in
  Fmt.pr
    {|
module Metadata (* : Remarcaml.META *) = struct
  let filename = "%s"
end

module File (* : Remarcaml.FILE *) = struct
  %s

  let nodes = [node1]
end |}
    filename
    contents
;;
