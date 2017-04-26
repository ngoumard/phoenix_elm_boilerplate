module Landing.View exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import App.Messages exposing (..)
import App.Models exposing (Model)
import Users.Models exposing (User)

import Landing.Partials.Hero exposing (heroView)

view : Model -> Html Msg
view model =
    div [ class "landing-landing" ]
        [ heroView model.user
        ]
