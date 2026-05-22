type text = string
type contact = Plain of string | Hyperlink of string * string
type headline = { name : string; contacts : contact list }

type heading = {
  title : string;
  subtitle : string;
  location : string;
  start_date : string;
  end_date : string option;
}

type item = { heading : heading option; bullets : text list }
type section = { title : string; items : item list }
type cv = { headline : headline; sections : section list }
