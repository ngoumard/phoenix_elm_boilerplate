module App.UrlUpdate exposing (..)

import Navigation exposing (newUrl)
import App.Messages exposing (Msg(..))
import App.Ports exposing (appTitle)
import App.Utils.Title exposing (..)
import App.Models exposing (Model)
import App.Routing as Routing exposing (Route(..), routeToPath)
import Users.Models as UserModels exposing (User)
import Users.Commands as UsersCmds
import Http exposing (decodeUri)
import String exposing (isEmpty)
import OAuth.Parser exposing (..)

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
      OAuthCallbackRoute provider ->
        let
          ( user, userCmd ) =
            authorizeUser location provider model.user
        in
          { model | user = user } ! [ userCmd ]
      NotFoundRoute ->
        model ! []

authorizeUser : Navigation.Location -> String -> User -> (User, Cmd Msg)
authorizeUser location provider user =
  let
    hash = location.search

    oauthResponse =
      { state = getFieldFromHash hash "state"
      , provider = provider
      , token = getFieldFromHash hash "code"
      }

    oauthResponsePresent =
      isEmpty provider
      || isEmpty oauthResponse.token
      || isEmpty oauthResponse.state
        |> not

    newUrlCmd =
      if oauthResponsePresent then
        decodeUri oauthResponse.state
          |> Maybe.withDefault ""
          |> newUrl
      else
        newUrl "/"
  in
    user ! [ newUrlCmd, UsersCmds.authorizeUser oauthResponse ]
    -- if user.status == UserModels.Unknown && oauthResponsePresent then
    --   { user | status = UserModels.Loading }
    --     ! [ newUrlCmd, UsersCmds.authorizeUser oauthResponse ]
    -- else
    --   ( user, newUrlCmd )
