module Landing.Partials.Feature exposing (renderFeatures)
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)

type alias FeatureItem = {
  title : String
  , text : String
  , linkText : String
  , linkTo : String
}

type alias FeatureItems = List FeatureItem

features : FeatureItems
features =
  [
    { title = "Feature", text = "Our tools empower you to grow your business in a way only you can.", linkText = "Explore Features", linkTo = "/features"}
    , { title = "Pricing", text = "Start sending emails today for free. Then level up as you grow.", linkText = "View Pricing", linkTo = "/pricing"}
    , { title = "E-Commerce", text = "Recapture sales, recommend products, and make money in your sleep.", linkText = "Connect Your Store", linkTo = "/connect"}
  ]

renderFeature : FeatureItem -> Html a
renderFeature feature =
  div [ class "feature" ]
      [ h2 [ class "title" ]
        [
          text feature.title
        ]
        , div [ class "text" ]
          [
            text feature.text
          ]
        , a [ class "shared-link", href feature.linkTo ]
          [
            text feature.linkText
          ]
      ]

renderFeatures : Html a
renderFeatures =
  let
    featureItemsHtml = List.map renderFeature features
  in
    div [ class "landing-features" ]
    (featureItemsHtml)
