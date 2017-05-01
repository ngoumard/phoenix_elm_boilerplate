module Signup.Update exposing (..)

import Signup.Messages as Msg exposing (Msg(..))
import Signup.Models as Model exposing (SignupModel, validate)
import Form exposing (Form)
import Form.Field as Field exposing (Field)
import Signup.Commands exposing(signup)
import App.Ports exposing (setLocalJWT)
import Navigation exposing (newUrl)
import App.Routing exposing (Route(DashboardRoute), routeToPath)
import App.Utils.Form exposing (getServerError)

update : Msg -> SignupModel -> (SignupModel, Cmd Msg)
update msg model =
  case msg of
    SignupSucceeded jwt ->
        { model | error = "", loading = False } ! []

    SignupFailed error ->
        { model | error = getServerError error, loading = False } ! []

    FormMsg formMsg ->
      case ( formMsg, Form.getOutput model.form ) of
        ( Form.Submit, Just credential ) ->
            { model | loading = True, error = "" } ! [ signup credential ]
        _ ->
            { model | form = (Form.update validate formMsg model.form) } ! []
