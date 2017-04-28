module Landing.Partials.Hero exposing (heroView)

import Html exposing (Html, div, text, p, h1, button, a, text)
import Html.Events exposing (..)
import Html.Attributes exposing (id, class, href, style)
import Landing.Partials.NavBar exposing (navBarView)
import Users.Models exposing (User)
import App.Messages exposing (..)

import App.Translations exposing (Language, translate, TranslationId(Cta, Title, SignupFree, CheckOurFeatures, WantToLearnMore))

heroView : User -> Language -> Html Msg
heroView user language =
  div [ class "landing-hero" ]
      [ div [ class "masthead" ]
            [ navBarView user language
              , h1 [ class "title" ]
                 [ text <| translate language Title ]
              , p [ class "value-proposition" ]
                  [ text <| translate language Cta ]
              , button [ class "button primary", style [("width", "200px")] ] [text <| translate language SignupFree]
              , div [ class "more" ]
                    [ text <| translate language WantToLearnMore
                    , a [ href "/features", class "shared-link" ] [ text <| translate language CheckOurFeatures ]
                    ]
            ]

      ]
