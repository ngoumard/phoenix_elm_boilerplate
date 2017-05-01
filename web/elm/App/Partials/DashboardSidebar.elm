module App.Partials.DashboardSidebar exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import App.Messages exposing (..)

import Components.Icon exposing (logoutIcon)

view : Html Msg
view =
  div [ class "dashboard-dashboardSidebar" ]
      [ text "sidebar"
      , div [ class "container-bottom" ]
            [ div [ class "content-bottom" ]
                  [ div [ class "brand" ]
                        [ text "Boilerplate"]
                    , div [ class "button-logout", onClick RemoveLocalJWT ]
                          [ Components.Icon.logoutIcon ]
                  ]

            ]
      ]
