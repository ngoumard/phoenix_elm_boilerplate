module Users.Commands exposing (..)
import App.Utils.Config exposing (apiUrl)
import Http
import App.Utils.Requests exposing (getWithAuth, post)
import Json.Decode as Decode exposing (..)
import Users.Models exposing(Profile)
import Users.Messages exposing (..)
import App.Messages exposing(Msg(UserAuthorization))

import OAuth.Config exposing (OAuthResponse)
-- import App.Messages exposing (Msg(UserAuthorization))
import Json.Encode as Encode

getCurrentUser : String -> Cmd Users.Messages.Msg
getCurrentUser jwt =
  getWithAuth currentUserUrl userDecoder jwt
    |> Http.send handleGetCurrentUserComplete

handleGetCurrentUserComplete : Result Http.Error Profile -> Users.Messages.Msg
handleGetCurrentUserComplete result =
  case result of
      Ok profile ->
        GetUserSucceeded profile

      Err error ->
        GetUserFailed error

currentUserUrl : String
currentUserUrl =
  apiUrl ++ "/me"

userDecoder : Decode.Decoder Profile
userDecoder =
  Decode.map Profile
    (field "email" Decode.string)

-- OAuth Callback

authorizeUser : OAuthResponse -> Cmd App.Messages.Msg
authorizeUser oauthResponse =
  post ("/api/v1/auth/" ++ oauthResponse.provider ++ "/callback") (tokenEncoded oauthResponse) tokenStringDecoder
    |> Http.send UserAuthorization

-- Decoders

tokenStringDecoder : Decode.Decoder String
tokenStringDecoder =
  Decode.map identity
    (field "jwt" Decode.string)

-- ENCODERS

tokenEncoded : OAuthResponse -> Encode.Value
tokenEncoded oauthResponse =
  -- let
  --   tokenData =
  --     [ ("token", Encode.string oauthResponse.token)
  --     , ("provider", Encode.string oauthResponse.provider)
  --     ]
  -- in
    Encode.object [ ("code", Encode.string oauthResponse.token) ]
