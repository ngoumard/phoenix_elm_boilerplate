module Components.Link exposing(view)

import Html exposing (..)
import Html.Attributes exposing (..)

view : String -> String -> String -> Html a
view to klass label =
  let
    cl = "shared-link" ++ klass
  in
    a [ href to, class cl ] [text label]
