module Login.Update exposing (..)
import App.Models exposing (Model)
import Navigation exposing (newUrl)
import Login.Models exposing (LoginModel, validate)
import Login.Messages exposing (Msg(..))
import Login.Commands exposing (login, getPhoenixError)
import Users.Commands exposing (getCurrentUser)
import App.Ports exposing (setLocalJWT)
import Users.Utils exposing (activateUser)
import App.Routing exposing (Route(DashboardRoute), routeToPath)
import Form exposing (Form)
import Form.Field as Field exposing (Field)
import Users.Models exposing (UserToken)


update : Msg -> LoginModel -> (LoginModel, Cmd Msg)
update msg model =
  case msg of
    NoOp ->
      model ! []

    LoginSucceeded jwt ->
        { model | error = "", loading = False } ! []

    LoginFailed error ->
        { model | error = getPhoenixError error, loading = False } ! []

    LoginFormMsg formMsg ->
      case ( formMsg, Form.getOutput model.form ) of
        ( Form.Submit, Just credential ) ->
            { model | loading = True, error = "" } ! [login credential]
        _ ->
            { model | form = (Form.update validate formMsg model.form) } ! []
