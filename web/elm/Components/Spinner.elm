module Components.Spinner exposing(spinnerView)

import Html exposing (..)
import Html.Attributes exposing (..)

spinnerView : String -> Html a
spinnerView content =
  div [ class "shared-spinner"]
  [
    div [ class "sk-spinner sk-spinner-pulse" ]
        [ text content ]
  ]
