%{
  open Other
%}

%token COLON
%token LEFT_BRACE
%token RIGHT_BRACE
%token <string> IDENT
%token EOF
%token <string> STRING
%start <node list> prog
%%

prog:
  | EOF { [] }
  | node = node { [node] }

node:
  | LEFT_BRACE; kind = IDENT; COLON; content = STRING; RIGHT_BRACE
    { Element { kind; args=[]; children = [Text content] } }
  | content = STRING
    { Text content }
