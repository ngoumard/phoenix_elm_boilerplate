module App.UrlUpdate exposing (..)

import Navigation exposing (newUrl)
import App.Messages exposing (Msg(..))
import App.Models exposing (Model)
import App.Routing as Routing exposing (Route(..), routeToPath)

urlUpdate : Navigation.Location -> Model -> (Model, Cmd Msg)
urlUpdate location model =
    case model.route of
      LandingRoute ->
        model ! []
      LoginRoute ->
        model ! []
      SignupRoute ->
        model ! []
      DashboardRoute ->
        if model.user.jwt /= "" then
          model ! []
        else
          model ! [newUrl (routeToPath (LoginRoute))]
      NotFoundRoute ->
        model ! []
