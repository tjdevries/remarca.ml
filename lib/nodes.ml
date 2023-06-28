open Base

module Attribute = struct
  type t = Italic [@@deriving ord, sexp]

  include (val Comparator.make ~compare ~sexp_of_t)
end

type attribute_set = (Attribute.t, Attribute.comparator_witness) Base.Set.t

let attr_empty = Set.empty (module Attribute)
let x = Set.empty (module Attribute)
let y = Set.add x Attribute.Italic

type node =
  | Statement of statement
  | Text of string * attribute_set
  | Image of image * node
  | Expr of string

and statement = node list
and image = { link : string }

let rec to_html nodes =
  List.fold_left nodes ~init:[] ~f:(fun acc node ->
    match node with
    | Statement st -> (String.concat ~sep:" " @@ to_html st) :: acc
    | Text (str, _) -> Fmt.str "<p>%s</p>" str :: acc
    | _ -> assert false)
;;

module Builtin = struct
  let i = function
    | Text (s, attrs) -> Text (s, Set.add attrs Italic)
    | node -> node
  ;;

  let italic = i
end

module File = struct
  let n1 = Text ("hello world", Set.empty (module Attribute)) |> Builtin.italic

  (* golang link & image example *)
  let golang_link = "https://golang.com/gopher.png"
  let n2 = Image ({ link = golang_link }, Text ("Wow, an image", attr_empty))

  (* Nodes for the file *)
  let nodes = [ n1; n2 ]
end

module Marcaml = struct
  let register_file _ _ = assert false
end

let () = Marcaml.register_file "posts/hello/nodes.rl" File.nodes

(* Get some new text *)
let new_text s = Text (s, attr_empty)
