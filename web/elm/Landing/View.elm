module Landing.View exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import App.Models exposing (Model)
import Users.Models exposing (User)
import App.Messages exposing (..)
import App.Translations exposing (Language)

import Landing.Partials.Hero exposing (heroView)
import Landing.Partials.Feature exposing (renderFeatures)
import Landing.Partials.Testimonial exposing (testimonialView)
import Landing.Partials.Footer exposing (footerView)

view : Model -> Language -> Html Msg
view model language =
    div [ class "landing-landing" ]
        [ heroView model.user language
        , renderFeatures
        , testimonialView
        , footerView language
        ]
