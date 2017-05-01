module Signup.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Form exposing (Form)
import Signup.Models as Model exposing (SignupModel)
import Signup.Messages as Msg exposing (Msg(..))
import App.Utils.Form exposing (textInput)
import Components.Link as Link exposing(view)

view : SignupModel ->  Html Msg
view model =
    div [ class "auth-signup" ]
        [ Html.map FormMsg (formView model)
        ]

formView : SignupModel -> Html Form.Msg
formView model =
  let
    formError =
      if model.error /= "" then
        div [class "form-error"] [text model.error]
      else
        text ""
  in
    div [ class "form-formSignup" ]
        [
          div
            [ class "forms-form" ]
            [ h1 [ class "header" ] [ text "Get started with a free account" ]
              , div [ class "subheader" ]
                    [ text "Already have an account?", Link.view "/login" "link-label" "Login"
                    ]
              , formError
              , div [ class "container-input" ]
                    [ textInput "text" (text "Email") ("Your email") (Form.getFieldAsString "email" model.form)
                      , textInput "password" (text "Password") ("Your password") (Form.getFieldAsString "password" model.form)
                      , div [class "container-cta"]
                            [button [ class "button primary base full-width", onClick Form.Submit] [text (if model.loading then "Signing up..." else "Signup")]
                            ]
                    ]
            ]
        ]
