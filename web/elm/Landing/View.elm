module Landing.View exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import App.Messages exposing (..)
import App.Models exposing (Model)
import Users.Models exposing (User)

import Landing.Partials.Hero exposing (heroView)
import Landing.Partials.Feature exposing (featureView)
import Landing.Partials.Testimonial exposing (testimonialView)
import Landing.Partials.Footer exposing (footerView)

view : Model -> Html Msg
view model =
    div [ class "landing-landing" ]
        [ heroView model.user
        , div [ class "landing-features" ]
        [
          featureView "Feature" "Our tools empower you to grow your business in a way only you can." "Explore Features" "/features"
          , featureView "Pricing" "Start sending emails today for free. Then level up as you grow." "View Pricing" "/pricing"
          , featureView "E-Commerce" "Recapture sales, recommend products, and make money in your sleep." "Connect Your Store" "/connect"
        ]
        , testimonialView
        , footerView
        ]
