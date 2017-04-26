module Signup.Commands exposing(..)

import Http
import Json.Encode as Encode
import Json.Decode as Decode exposing (field)
import Signup.Models exposing (Credential)
import App.Utils.Config exposing (apiUrl)
import App.Utils.Requests exposing (post)
import Signup.Messages exposing (Msg(GetToken))

signup : Credential -> Cmd Msg
signup credential =
    post signupUrlPOST (credentialEncoded credential) tokenStringDecoder
      |> Http.send GetToken

signupUrlPOST : String
signupUrlPOST =
  apiUrl ++ "/signup"

credentialEncoded : Credential -> Encode.Value
credentialEncoded credentialModel =
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
