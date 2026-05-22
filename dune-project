(lang dune 3.23)

(name vitae)

(generate_opam_files true)

(using menhir 2.0)

(source
 (github teleohead/vitae))

(authors "Yubing Zhang <joseph.zyb@gmail.com>")

(maintainers "Yubing Zhang <joseph.zyb@gmail.com>")

(license MIT)

(package
 (name vitae)
 (synopsis "A high-performance, type-safe DSL resume compiler in OCaml")
 (description "A native CLI compiler that transforms custom lightweight markdown-style documents into beautifully typeset PDFs via direct vector generation.")
 (depends ocaml dune otoml menhir camlpdf)
 (tags
  (compiler dsl resume pdf)))
