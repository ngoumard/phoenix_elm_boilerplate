module Signup.Update exposing (..)

import Signup.Messages as Msg exposing (Msg(..))
import Signup.Models as Model exposing (SignupModel, validate)
import Form exposing (Form)
import Form.Field as Field exposing (Field)
import Signup.Commands exposing(signup)
import App.Ports exposing (setLocalJWT)
import Navigation exposing (newUrl)
import App.Routing exposing (Route(DashboardRoute), routeToPath)

update : Msg -> SignupModel -> (SignupModel, Cmd Msg)
update msg model =
  case msg of
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
                  form = Form.update validate (Form.Input "password" Form.Text <| Field.String "") model.form
                , loading = True
                , error = ""
            }
                ! [ signup credential ]
        _ ->
            { model | form = (Form.update validate formMsg model.form) } ! []
