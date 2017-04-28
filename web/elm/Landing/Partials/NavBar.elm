module Landing.Partials.NavBar exposing (navBarView)
import Components.Link as Link exposing(view)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Users.Models exposing (User)
import App.Translations exposing (Language(..), translate, TranslationId(Signup, Login))
import App.Messages exposing (..)

navBarView : User -> Language -> Html Msg
navBarView user language =
  let
    content =
      if user.jwt == "" then
        div [ class "signup" ]
            [
              Link.view "/signup" "button primary small no-border" (translate language Signup)
              , a [ href "/login", class "shared-link no-border"][text <| translate language Login]
            ]
      else
        Link.view "/dashboard" "" "Dashboard"
  in
    div [ class "landing-navbar"]
        [ content
        , button [ onClick (ChangeLanguage (if language == French then English else French))]
                 [text (if language == French then "En" else "Fr")]
        ]
