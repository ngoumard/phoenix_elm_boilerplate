module Login.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Login.Models exposing (LoginModel)

import Login.Messages exposing (..)
import Login.Form as LoginForm
import Components.Link as Link exposing(view)
import OAuth.Config exposing (..)

view : LoginModel -> Html Msg
view loginModel =
    div [ class "auth-login" ]
        [
          div [ class "form-container" ] [
            Html.map LoginFormMsg (LoginForm.view loginModel)
            , a [ href <| buildAuthUrl (googleAuthClient "/login"), class "button secondary container-google-button" ]
                [ div []
                      [
                        span [class "google-button"]
                              [img [src "https://upload.wikimedia.org/wikipedia/commons/5/53/Google_%22G%22_Logo.svg", style [("height", "24px"),("width", "24px")], class "logo-google"][]
                                ,text "Login with google"
                              ]
                      ]
                ]
            , div [ class "container-forgot" ]
            [
              Link.view "/forgot-password" "" "Forgot password?"
            ]
          ]
          , div [ class "illustration" ] [ div [ class "image-container"] []]
        ]
