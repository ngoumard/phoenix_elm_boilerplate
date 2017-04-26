module Landing.Partials.Hero exposing (heroView)

import Html exposing (Html, div, text, p, h1, button, a, text)
import Html.Events exposing (..)
import Html.Attributes exposing (id, class, href, style)
import Landing.Partials.NavBar exposing (navBarView)
import Users.Models exposing (User)

heroView : User -> Html msg
heroView user =
  div [ class "landing-hero" ]
      [ div [ class "masthead" ]
            [ navBarView user
              , h1 [ class "title" ]
                 [ text "A great value proposition" ]
              , p [ class "value-proposition" ]
                  [ text "Join more than 14 million people who use Phoenix & Elm to grow their businesses on their terms." ]
              , button [ class "button primary", style [("width", "200px")] ] [text "Sign Up Free"]
              , div [ class "more" ]
                    [ text "Want to learn more? "
                    , a [ href "/features", class "shared-link" ] [ text "Check out our features" ]
                    ]
            ]

      ]
