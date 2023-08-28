open Base

module Attribute = struct
  type t =
    | Italic
    | Bold
    | Custom of string
  [@@deriving ord, sexp]

  include (val Comparator.make ~compare ~sexp_of_t)
end

type attribute_set = (Attribute.t, Attribute.comparator_witness) Base.Set.t

let attribute_set_of_sexp _ = failwith "set of sexp"

let sexp_of_attribute_set set =
  Base.Set.to_list set |> sexp_of_list Attribute.sexp_of_t
;;

let attr_empty = Set.empty (module Attribute)
let x = Set.empty (module Attribute)
let y = Set.add x Attribute.Italic

type node =
  | Text of string
  | Literal of string
  | Container of container
  | Image of image * node list
  | Comment of string

and container = Attribute.t * node list
and statement = node list
and image = { link : string } [@@deriving sexp]

type document = { statements : statement list } [@@deriving sexp]

(* What if we did something like *)
type doc_node =
  [ `Text of string
  | `Literal of string
  | `Container of container
  ]

and ast_node =
  [ `Text of string
  | `Container of container
  ]

(* 
   Hmm, i think maybe we should have two types:
     document_nodes
     processed_nodes or concrete_nodes

   We run a pass of `process nodes state` -> processed_nodes list

   And then you have the final ones do the formatting.
    (for example, we can't have any literal things left when
     we get to rendering. We want those to all be evaluated to
     some concrete node)


 *)

let rec to_html nodes =
  List.fold_left nodes ~init:[] ~f:(fun acc node ->
    match node with
    | Text str -> Fmt.str "<p>%s</p>" str :: acc
    | Container (Attribute.Italic, nodes) ->
      Fmt.str "<i>%s</i>" (to_html nodes) :: acc
    | Container (Attribute.Bold, nodes) ->
      Fmt.str "<em>%s</em>" (to_html nodes) :: acc
    | _ -> assert false)
  |> String.concat ~sep:""
;;

module Builtin = struct
  let italic node = Container (Attribute.Italic, [ node ])
  let bold node = Container (Attribute.Bold, [ node ])
end

module File = struct
  let n1 = Text "hello world" |> Builtin.italic

  (* golang link & image example *)
  let golang_link = "https://golang.com/gopher.png"
  let n2 = Image ({ link = golang_link }, [ Text "Wow, an image" ])

  (* Nodes for the file *)
  let nodes = [ n1; n2 ]
end

(* Get some new text *)
let new_text s = Text s
let new_document statements = { statements }
let new_statement node = [ node ]
