
{i: {i: hello world } }
-> Text ("hello world", Set.empty (module Attribute))
   |> Builtin.italic
   |> Builtin.italic

- hello
  - this is still good *hello* {b: hello}
  - can actually use conceal to hide {code: \{b:hello\}}

{stop}

# let my_slide = slide ~sticky:true ~incremental:false

{slide sticky=true incremental=false:
- You can always provide defaults
- New params don't break anything
- You can curry :)
- Normal ocaml stuff w/ functions.
- main question is ~ and : vs. just using = (or similar)

{slide ~sticky:true ~incremental:false :
  {title: Overview}

  - Overview of extending Neovim
  {stop}
  - Explore why those methods have been successful
    - or at least why I think it's fun! :)

}

{my_slide: {title: Overview}

  - Overview of extending Neovim
  {stop}
  - Explore why those methods have been successful
    - or at least why I think it's fun! :)

}

// Can add line comments as well :)
// Should be able to do: {Module.node ... : ... }
// {code: code snippet is just ` with expand}, very nice

# open Base
# let golang_link = "https://golang.com/gopher.png" 

This is not ocaml.

# print_endline "this is ocaml"

#(let golang_link =
        "https://golang.com/gopher.png")

{img { link = golang_link }: Wow, an image }

{id "hello" }


Hello world
|> #(fun x -> String.length x)

#import MyMelangeModule

{ref: MyTag}
:ref:MyTag
:ref:MyTag:
::ref:MyTag
#ref:MyTag

<ref>MyTag</ref>

${ hello ${ }  }
 ^^^^^^^^^^^^
          ^^^^^^

{ hello { world } }
^^^^^^^^^^^^^^^^^^^
        ^^^^^^^^^

{ {name: MyTag} |> String.lower }

hello {i: world}
// Node

#name(mytag)

>::<MyTag>

>ref<MyTag
>:(MyTag):<

:ref.MyTag

ref:[something](something)

$ref['MyTag']
$ref[MyTag]
