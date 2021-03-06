module App.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
-- import Http exposing (decodeUri)
import App.Messages exposing (Msg(..))
import App.Models exposing (Model)
import App.Routing as Routing exposing (Route(..))
import Pages.NotFoundPage as NotFoundPage
import Landing.View as LandingView
import Login.View as LoginView
import Signup.View as SignupView
import Dashboard.View as DashboardView
import App.Partials.DashboardSidebar exposing (..)


view : Model -> Html Msg
view model =
  page model


page : Model -> Html Msg
page model =
  let
    page =
      case model.route of
        LandingRoute ->
          LandingView.view model model.appLanguage
        SignupRoute ->
          SignupView.view model.signup
            |> Html.map SignupMsg
        LoginRoute ->
          LoginView.view model.login
            |> Html.map LoginMsg
        DashboardRoute ->
          DashboardView.view model
        OAuthCallbackRoute provider ->
          div [] []
        NotFoundRoute ->
          NotFoundPage.view
  in
    case model.route of
      DashboardRoute ->
        div [class "dashboard-dashboardContainer"]
            [ App.Partials.DashboardSidebar.view,
              div [ class "container-content" ]
                  [ page ]
            ]
      _ ->
        page
