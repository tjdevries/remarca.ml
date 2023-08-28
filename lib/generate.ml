open Base

type x = string Location.loc

let generate (doc : Nodes.document) =
  List.mapi doc.statements ~f:(fun idx stmt ->
    Fmt.str
      "let node%d = {| %s |}"
      idx
      (Nodes.sexp_of_statement stmt |> Sexp.to_string))
  |> String.concat ~sep:"\n"
;;
