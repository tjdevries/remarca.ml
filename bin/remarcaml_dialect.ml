open Base
open Remarcaml

let args = Sys.get_argv () |> Array.to_list

let () =
  let filename = List.nth_exn args 1 in
  let contents = Bos.OS.File.read (Fpath.v filename) in
  let contents =
    match contents with
    | Ok contents -> Parse.parse (String.strip contents)
    | Error _ ->
      Fmt.pr "Parse to read : %s" filename;
      Stdlib.exit 0
  in
  let generated =
    match contents with
    | Ok contents -> Generate.generate contents
    | Error err ->
      Fmt.pr "Generated failed with: %s" err;
      Stdlib.exit 0
  in
  Fmt.pr
    {|
module Metadata (* : Remarcaml.META *) = struct
  let filename = "%s"
end

module File (* : Remarcaml.FILE *) = struct
  %s

  let nodes = [node0]
end |}
    filename
    generated
;;
