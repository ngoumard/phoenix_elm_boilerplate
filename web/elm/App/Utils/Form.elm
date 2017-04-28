module App.Utils.Form exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Form exposing (Form)
import Form.Input as Input
import Form.Error exposing (Error, ErrorValue)

textInput : String -> Html Form.Msg -> String -> Form.FieldState e String -> Html Form.Msg
textInput inputType label_ placeholder_ state =
  let
    inputClass =
      if state.liveError /= Nothing then
        "input error"
      else
        "input"
    requiredStar = span [class "required-star"] [text "*"]
  in
    div [ class "forms-input" ]
        [ label [ class "forms-label" ] [ span [] [ label_, requiredStar ], errorMessage state.liveError ]
        , Input.textInput state [ type_ inputType, class inputClass, value (Maybe.withDefault "" state.value), placeholder placeholder_ ]
        ]

errorMessage : Maybe (ErrorValue e) -> Html Form.Msg
errorMessage maybeError =
    case maybeError of
        Just error ->
          let
            errorString =
              case error of
                Form.Error.InvalidString ->
                  "Invalid"
                Form.Error.Empty ->
                  "Cannot be blank"
                Form.Error.InvalidEmail ->
                  "Invalid email"
                Form.Error.CustomError errString ->
                  toString errString
                _ ->
                  toString error
          in
            span [ class "error-or-warning error" ] [ text errorString ]
        Nothing ->
            text ""
