type node =
  | Text of string
  | OCamlLiteral of string
  | List of
      { level : int
      ; content : node list
      }
  | Leaf of
      { kind : string
      ; args : (string * expr) list
      }
  | Element of
      { kind : string
      ; args : (string * expr) list
      ; children : node list
      }

and expr =
  | True
  | False
