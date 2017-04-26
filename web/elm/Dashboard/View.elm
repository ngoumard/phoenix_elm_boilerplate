module Dashboard.View exposing (..)

import Html exposing (Html, div, text, button)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import App.Messages exposing (..)

view : Html Msg
view =
    div []
        [ text "This is a protected page"
        , button [onClick RemoveLocalJWT]
               [text "logout"]
        ]
