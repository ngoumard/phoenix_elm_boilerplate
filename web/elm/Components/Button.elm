module Components.Button exposing(buttonView)

import Html exposing (..)
import Html.Attributes exposing (..)

import Components.Spinner exposing(spinnerView)

buttonView : String -> String -> Bool -> Html a
buttonView klass label loading =
  let
    content = if loading then spinnerView "loading" else text label
  in
    button [ class ("button " ++ klass) ] [content]
