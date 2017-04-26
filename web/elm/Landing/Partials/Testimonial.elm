module Landing.Partials.Testimonial exposing (testimonialView)
import Html exposing (..)
import Html.Attributes exposing (..)

testimonialView : Html a
testimonialView =
  div [ class "landing-testimonial" ]
      [ div [ class "container" ]
            [ div [ class "picture" ] []
              , div [ class "name" ]
                    [ text "Joe Lapin"]
              , p [ class "description" ]
                  [ text "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
                  ]
            ]
      ]
