module App.Update exposing (..)

import String exposing (length)
import Navigation exposing (newUrl)
import App.Messages exposing (Msg(..))
import App.Models exposing (Model)
import App.Routing exposing (Route(..), routeToPath, parseLocation, navigateTo)
import App.Ports exposing (setLocalLanguage, setLocalJWT, removeLocalJWT)
import App.UrlUpdate exposing (urlUpdate)
import Users.Models exposing (userInitialModel, UserToken)
import Users.Utils exposing (activateUser)
import Users.Commands exposing (getCurrentUser)
import Users.Messages as UsersMsgs
import Users.Update as UsersUpdate
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
        case subMsg of
          LoginMsgs.LoginSucceeded jwt ->
            { model | user = activateUser jwt } ! [ setLocalJWT jwt, Cmd.map UsersMsg(getCurrentUser jwt) ]
          _ ->
            { model | login = newLoginModel } ! [ Cmd.map LoginMsg cmd ]

    SignupMsg subMsg ->
      let
        (newSignupModel, cmd) =
          SignupUpdate.update subMsg model.signup
      in
        case subMsg of
          SignupMsgs.SignupSucceeded jwt ->
            { model | user = activateUser jwt } ! [ setLocalJWT jwt, Cmd.map UsersMsg(getCurrentUser jwt) ]
          _ ->
            { model | signup = newSignupModel } ! [ Cmd.map SignupMsg cmd ]

    FetchCurrentUser ->
      { model | loading = True } ! [ Cmd.map UsersMsg(getCurrentUser model.user.jwt) ]

    UsersMsg subMsg ->
      case subMsg of
        UsersMsgs.GetUserSucceeded profile ->
          { model | profile = profile, loading = False } ! [newUrl (routeToPath (DashboardRoute))]
        _ ->
          model ! []

    RemoveLocalJWT ->
      { model | user = userInitialModel }
        ! [ removeLocalJWT (), newUrl (routeToPath (LandingRoute)) ]

    ChangeLanguage language ->
      { model | appLanguage = language }
        ! [ setLocalLanguage <| toString language
          , Navigation.modifyUrl <| routeToPath (model.route)
          ]

    NoOp ->
      (model, Cmd.none)
