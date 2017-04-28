module Landing.Partials.Footer exposing (footerView)
import Html exposing (..)
import Html.Attributes exposing (..)

import App.Translations exposing (Language, translate, TranslationId(TryItFree))

footerView : Language -> Html a
footerView language =
  div [ class "landing-footer" ]
      [ div [ class "container" ]
            [ div [ class "container-text" ]
                  [ div [ class "header" ]
                        [ text "Ready to try it ?"]
                  , div [ class "value-proposition" ]
                        [ text "No obligations, no credit card required."]
                  ]
              , div [ class "container-button" ]
                    [ button [ class "button primary small" ] [ text <| translate language TryItFree ] ]
            ]
      ]
