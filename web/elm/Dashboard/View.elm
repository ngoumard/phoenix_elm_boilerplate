module Dashboard.View exposing (..)

import Html exposing (Html, div, text, button)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import App.Messages exposing (..)
import App.Models exposing (Model)
-- import Users.Models exposing (Profile)

view : Model -> Html Msg
view model =
    div [ class "dashboard-dashboardMain" ]
        [ text "This is a protected page"
        , text ("email -> " ++ model.profile.email)
        , text (if model.loading then "LOADING" else "NOTLOADING")
        , button [onClick FetchCurrentUser]
                  [ text "fetch" ]
        ]
