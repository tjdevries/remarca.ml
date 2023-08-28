open Base
open Angstrom

let ws =
  skip_while (function
    | '\x20' | '\x0a' | '\x0d' | '\x09' -> true
    | _ -> false)
;;

let text =
  take_while1 (function
    | c when Char.is_alphanum c -> true
    | ' ' -> true
    | _ -> false)
  |> map ~f:(fun str -> String.strip str |> Nodes.new_text)
;;

let eol =
  take_while (function
    | '\n' -> true
    | _ -> false)
;;

let container c f = char '{' *> c *> char ':' *> text <* char '}' |> map ~f
let italic = container (char 'i') Nodes.Builtin.italic
let bold = container (char 'b') Nodes.Builtin.bold
let node = choice [ italic; bold ]
let statement = choice [ text; node ] <* eol |> map ~f:Nodes.new_statement
let file = many statement |> map ~f:Nodes.new_document
let parse input = parse_string ~consume:All file input
