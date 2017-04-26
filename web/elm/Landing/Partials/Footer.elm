module Landing.Partials.Footer exposing (footerView)
import Html exposing (..)
import Html.Attributes exposing (..)

footerView : Html a
footerView =
  div [ class "landing-footer" ]
      [ div [ class "container" ]
            [ div [ class "container-text" ]
                  [ div [ class "header" ]
                        [ text "Ready to try it ?"]
                    , div [ class "value-proposition" ]
                          [ text "No obligations, no credit card required."]
                  ]
              , div [ class "container-button" ]
                    [ button [ class "button primary small" ] [ text "Try it for free" ] ]
            ]
      ]
