module Login.Commands exposing (..)

import Http
import Json.Encode as Encode
import Json.Decode as Decode exposing (..)
import App.Utils.Config exposing (apiUrl)
import App.Utils.Requests exposing (post)
import Login.Models exposing (Credential, LoginModel, loginModelInit)
import Login.Messages exposing (Msg(..))
import Json.Decode.Extra exposing ((|:))

-- HTTP Requests

login : Credential -> Cmd Msg
login credential =
  post loginUrlPOST (loginEncoded credential) tokenStringDecoder
    |> Http.send handleLoginComplete

handleLoginComplete : Result Http.Error String -> Msg
handleLoginComplete result =
    case result of
        Ok tokenId ->
            LoginSucceeded tokenId

        Err error ->
            LoginFailed error

-- URLs

loginUrlPOST : String
loginUrlPOST =
  apiUrl ++ "/login"


-- ENCODERS

loginEncoded : Credential -> Encode.Value
loginEncoded credentialModel =
  let
    credential =
      [ ("email", Encode.string credentialModel.email)
      , ("password", Encode.string credentialModel.password)
      ]
  in
    Encode.object credential

tokenStringDecoder : Decode.Decoder String
tokenStringDecoder =
  Decode.map identity
    (field "jwt" Decode.string)

-- HELPERS

getPhoenixError : Http.Error -> String
getPhoenixError error =
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
