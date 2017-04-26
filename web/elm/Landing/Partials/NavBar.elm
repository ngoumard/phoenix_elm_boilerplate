module Landing.Partials.NavBar exposing (navBarView)
import Components.Link as Link exposing(view)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Users.Models exposing (User)

navBarView : User -> Html msg
navBarView user =
  let
    content =
      if user.jwt == "" then
        div [ class "signup" ]
            [
              Link.view "/signup" "button primary small no-border" "Signup"
              , a [ href "/login", class "shared-link no-border"][text "Login"]
            ]
      else
        Link.view "/dashboard" "" "Dashboard"
  in
    div [ class "landing-navbar"]
        [ content ]
