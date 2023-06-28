let () = print_endline "Hello, World!"
let get_all_nodes () = []
let generate_backlinks _ = assert false

let _ =
  let nodes = get_all_nodes () in
  let state = generate_backlinks nodes in
  state
;;

let register_attribute _ _ = assert false
let _ = register_attribute "id" (fun node -> node)
