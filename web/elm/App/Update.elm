module App.Update exposing (..)

import String exposing (length)
import Navigation exposing (newUrl)
import App.Messages exposing (Msg(..))
import App.Models exposing (Model)
import App.Routing exposing (Route(..), routeToPath, parseLocation, navigateTo)
import App.Ports exposing (setLocalJWT, removeLocalJWT)
import App.UrlUpdate exposing (urlUpdate)
import Users.Models exposing (userInitialModel)
import Users.Utils exposing (activateUser)
import Login.Update as LoginUpdate
import Login.Messages as LoginMsgs
import Signup.Messages as SignupMsgs
import Signup.Update as SignupUpdate

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    OnLocationChange location ->
      let
        currentRoute =
          parseLocation location
      in
        urlUpdate location {model | route = currentRoute}

    LoginMsg subMsg ->
      let
        (newLoginModel, cmd) =
          LoginUpdate.update subMsg model.login
      in
        { model | login = newLoginModel } ! [ Cmd.map LoginMsg cmd ]

    SignupMsg subMsg ->
      let
        (newSignupModel, cmd) =
          SignupUpdate.update subMsg model.signup
      in
        { model | signup = newSignupModel } ! [ Cmd.map SignupMsg cmd ]

    RemoveLocalJWT ->
      { model | user = userInitialModel }
        ! [ removeLocalJWT (), newUrl (routeToPath (LandingRoute)) ]

    NoOp ->
      (model, Cmd.none)
