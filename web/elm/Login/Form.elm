module Login.Form exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Login.Messages exposing (Msg(..))
import Login.Models exposing (LoginModel)
import Form exposing (Form)
import App.Utils.Form exposing (textInput)

-- debug form errors
dumpErrors : Form e o -> Html msg
dumpErrors form =
    let
        line ( name, error ) =
            name ++ ": " ++ (toString error)

        content =
            Form.getErrors form |> List.map line |> String.join "\n"
    in
        pre [] [ text content ]

isValid : Form e o -> Bool
isValid form =
  List.isEmpty(Form.getErrors form)

view : LoginModel -> Html Form.Msg
view loginModel =
  let
    formError =
      if loginModel.error /= "" then
        div [class "form-error"] [text loginModel.error]
      else
        text ""
  in
    div [class "form-formLogin"]
        [
        div [ class "forms-form" ]
        [
        h1 [class "header"] [text "Login in"]
        , div [class "subheader"] [text ("Need an account?" ++ " "), a [href "/signup", class "shared-link link-label"] [text "Create one"] ]
        , formError
        -- , dumpErrors loginModel.form
        , div [class "container-input"]
        [
          textInput "text" (text "Email") "Your Email" (Form.getFieldAsString "email" loginModel.form)
          , textInput "password" (text "Password") "Your Password" (Form.getFieldAsString "password" loginModel.form)
        ]
        , div [class "container-cta"]
        [
          button [ class "button primary base full-width", onClick Form.Submit, disabled (loginModel.loading || not(isValid loginModel.form))] [text (if loginModel.loading then "Logging in..." else "Log in")]
        ]
        ]]
