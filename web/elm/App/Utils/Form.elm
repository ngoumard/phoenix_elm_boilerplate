module App.Utils.Form exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Form exposing (Form)
import Form.Input as Input
import Form.Error exposing (Error, ErrorValue)
import Json.Encode as Encode
import Json.Decode as Decode exposing (..)
import Json.Decode.Extra exposing ((|:))
import Http

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
        , Input.textInput state [ type_ inputType, class inputClass, Html.Attributes.value (Maybe.withDefault "" state.value), placeholder placeholder_ ]
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

getServerError : Http.Error -> String
getServerError error =
    case error of
        Http.BadStatus response ->
          case Decode.decodeString errorListDecoder response.body of
            Ok errors ->
              String.concat(errors.errors |> List.map (\err -> ( err.detail )))

            Err er ->
              "Erreurrr"

        _ ->
            toString error

type alias ErrorResponse = {
  title: String,
  status: Int,
  id: String,
  detail: String
}

type alias ListErrorResponse = {
  errors : List ErrorResponse
}

errorListDecoder : Decode.Decoder ListErrorResponse
errorListDecoder =
    Decode.succeed
        ListErrorResponse
        |: (field "errors" (Decode.list errorDecoder))

errorDecoder : Decode.Decoder ErrorResponse
errorDecoder =
    Decode.succeed
        ErrorResponse
        |: (field "title" Decode.string)
        |: (field "status" Decode.int)
        |: (field "id" Decode.string)
        |: (field "detail" Decode.string)
