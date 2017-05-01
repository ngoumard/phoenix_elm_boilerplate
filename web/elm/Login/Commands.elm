module Login.Commands exposing (..)

import Http
import Json.Encode as Encode
import Json.Decode as Decode exposing (..)
import App.Utils.Config exposing (apiUrl)
import App.Utils.Requests exposing (post)
import Login.Models exposing (Credential, LoginModel, loginModelInit)
import Login.Messages exposing (Msg(..))

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
