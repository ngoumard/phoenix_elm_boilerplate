module Login.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Login.Models exposing (LoginModel)

import Login.Messages exposing (..)
import Login.Form as LoginForm
import Components.Link as Link exposing(view)

view : LoginModel -> Html Msg
view loginModel =
    div [ class "auth-login" ]
        [
          div [ class "form-container" ] [
            Html.map LoginFormMsg (LoginForm.view loginModel)
            , div [ class "container-forgot" ]
            [
              Link.view "/forgot-password" "" "Forgot password?"
            ]
          ]
          , div [ class "illustration" ] [ div [ class "image-container"] []]
        ]
