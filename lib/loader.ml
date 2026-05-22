open Ast
open Otoml

(* Headline *)

let parse_name (toml : Otoml.t) : string =
  find toml get_string [ "headline"; "name" ]

let parse_contact (toml : Otoml.t) : Ast.contact =
  match find_opt toml get_string [] with
  | Some plain_str -> Plain plain_str
  | None ->
      let text = find toml get_string [ "text" ] in
      let url = find toml get_string [ "url" ] in
      Hyperlink (text, url)

let parse_headline (toml : Otoml.t) : Ast.headline =
  let name = parse_name toml in
  let contacts =
    find toml (get_array Fun.id) [ "headline"; "contacts" ]
    |> List.map parse_contact
  in
  { name; contacts }

(* Sections *)

let parse_heading (toml : Otoml.t) : Ast.heading =
  {
    title = find toml get_string [ "title" ];
    subtitle = find toml get_string [ "subtitle" ];
    location = find toml get_string [ "location" ];
    start_date = find toml get_string [ "start_date" ];
    end_date = find_opt toml get_string [ "end_date" ];
  }

let parse_text (raw : string) : Ast.text = raw

let parse_item (toml : Otoml.t) : Ast.item =
  let heading =
    find_opt toml Fun.id [ "heading" ] |> Option.map parse_heading
  in
  let bullets =
    find_opt toml (get_array get_string) [ "bullets" ]
    |> Option.value ~default:[] |> List.map parse_text
  in
  { heading; bullets }

let parse_section (toml : Otoml.t) : Ast.section =
  let title = find toml get_string [ "title" ] in
  let items =
    find_opt toml (get_array Fun.id) [ "items" ]
    |> Option.value ~default:[] |> List.map parse_item
  in
  { title; items }

(* CV *)

let parse_cv (toml : Otoml.t) : Ast.cv =
  let headline = find toml Fun.id [ "headline" ] |> parse_headline in
  let sections =
    find_opt toml (get_array Fun.id) [ "sections" ]
    |> Option.value ~default:[] |> List.map parse_section
  in
  { headline; sections }

let load_cv (filename : string) : Ast.cv =
  let toml = Otoml.Parser.from_file filename in
  parse_cv toml
