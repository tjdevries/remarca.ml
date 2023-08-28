(lang dune 3.8)

(name remarcaml)

(generate_opam_files true)

(source
 (github tjdevries/remarcaml))

(authors "TJ DeVries")
(maintainers "TJ DeVries")
(license MIT)

(documentation https://github.com/tjdevries/remarcaml)

(dialect
  (name "remarcaml")
  (implementation
    (extension "rl")
    (preprocess (run remarcaml_dialect %{input-file})))
    ;; TODO: Add format, not sure how to call ocamlformat
  (interface
    (extension "rli")))

(package
 (name remarcaml)
 (synopsis "A short synopsis")
 (description "A longer description")
 (depends ocaml dune base fmt ppx_deriving ppx_sexp_conv sexplib bos compiler-libs angstrom)
 (tags
  (topics "to describe" your project)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
