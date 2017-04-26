module Landing.Partials.Feature exposing (featureView)
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)

featureView : String -> String -> String -> String -> Html a
featureView title text_ linkText linkTo =
  div [ class "feature" ]
      [ h2 [ class "title" ]
        [
          text title
        ]
        , div [ class "text" ]
          [
            text text_
          ]
        , a [ class "shared-link", href linkTo ]
          [
            text linkText
          ]
      ]
