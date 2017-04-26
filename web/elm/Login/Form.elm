module Login.Form exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Login.Messages exposing (Msg(..))
import Login.Models exposing (LoginModel)
import Form exposing (Form)
import App.Utils.Form exposing (textInput)

view : LoginModel -> Html Form.Msg
view loginModel =
    div [class "form-formLogin"]
        [
        div [ class "forms-form" ]
        [
        h1 [class "header"] [text "Login in"]
        , div [class "subheader"] [text "Need an account?", a [href "/signup", class "shared-link link-label"] [text "Create one"] ]
        , div [class "container-input"]
        [
          textInput "text" (text "Email") "Your Email" (Form.getFieldAsString "email" loginModel.form)
          , textInput "password" (text "Password") "Your Password" (Form.getFieldAsString "password" loginModel.form)
        ]
        , div [class "container-cta"]
        [
          button [ class "button primary base full-width", onClick Form.Submit] [text (if loginModel.loading then "Login in" else "Login")]
        ]
        ]]
