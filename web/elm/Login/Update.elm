module Login.Update exposing (..)
import App.Models exposing (Model)
import Navigation exposing (newUrl)
import Login.Models exposing (LoginModel, validate)
import Login.Messages exposing (Msg(..))
import Login.Commands exposing (login)
import App.Ports exposing (setLocalJWT)
import Users.Utils exposing (activateUser)
import App.Routing exposing (Route(DashboardRoute), routeToPath)
import Form exposing (Form)
import Form.Field as Field exposing (Field)


update : Msg -> LoginModel -> (LoginModel, Cmd Msg)
update msg model =
  case msg of
    NoOp ->
      model ! []

    GetToken (Ok jwt) ->
        { model | error = "", loading = False }
        ! [setLocalJWT jwt, newUrl (routeToPath (DashboardRoute)) ]

    GetToken (Err error) ->
        { model | error = toString error, loading = False } ! []

    FormMsg formMsg ->
      case ( formMsg, Form.getOutput model.form ) of
        ( Form.Submit, Just credential ) ->
            { model
                |
                loading = True
                , error = ""
            }
                ! [login credential]
        _ ->
            { model | form = (Form.update validate formMsg model.form) } ! []
