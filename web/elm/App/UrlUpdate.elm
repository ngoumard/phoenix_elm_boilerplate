module App.UrlUpdate exposing (..)

import Navigation exposing (newUrl)
import App.Messages exposing (Msg(..))
import App.Ports exposing (appTitle)
import App.Utils.Title exposing (..)
import App.Models exposing (Model)
import App.Routing as Routing exposing (Route(..), routeToPath)

urlUpdate : Navigation.Location -> Model -> (Model, Cmd Msg)
urlUpdate location model =
    case model.route of
      LandingRoute ->
        model ! [appTitle (newAppTitle "landingTitle")]
      LoginRoute ->
        model ! [appTitle (newAppTitle "login")]
      SignupRoute ->
        model ! []
      DashboardRoute ->
        if model.user.jwt /= "" then
          model ! []
        else
          model ! [newUrl (routeToPath (LoginRoute))]
      NotFoundRoute ->
        model ! []
