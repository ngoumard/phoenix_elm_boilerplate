module Components.Icon exposing (..)

import Svg
import Svg.Attributes

import Html exposing (Html)
import Html.Attributes exposing (class)

logoutIcon : Html a
logoutIcon =
  Svg.svg [ Svg.Attributes.viewBox "0 0 20 20", Svg.Attributes.class "shared-icon icon-logout" ]
      [ Svg.path [ Svg.Attributes.fill "none", Svg.Attributes.d "M13.53,2.238c-0.389-0.164-0.844,0.017-1.01,0.41c-0.166,0.391,0.018,0.845,0.411,1.01c2.792,1.181,4.598,3.904,4.6,6.937c0,4.152-3.378,7.529-7.53,7.529c-4.151,0-7.529-3.377-7.529-7.529C2.469,7.591,4.251,4.878,7.01,3.683C7.401,3.515,7.58,3.06,7.412,2.67c-0.17-0.392-0.624-0.571-1.014-0.402c-3.325,1.44-5.472,4.708-5.47,8.327c0,5.002,4.069,9.071,9.071,9.071c5.003,0,9.073-4.07,9.073-9.071C19.07,6.939,16.895,3.659,13.53,2.238z" ] []
      , Svg.path [ Svg.Attributes.fill "none", Svg.Attributes.d "M9.999,7.616c0.426,0,0.771-0.345,0.771-0.771v-5.74c0-0.426-0.345-0.771-0.771-0.771c-0.427,0-0.771,0.345-0.771,0.771v5.74C9.228,7.271,9.573,7.616,9.999,7.616z" ] []
      ]
