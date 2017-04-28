module Users.Commands exposing (..)
import App.Utils.Config exposing (apiUrl)
import Http
import App.Utils.Requests exposing (getWithAuth)
import Json.Decode as Decode exposing (..)
import Users.Models exposing(Profile)
import Users.Messages exposing (..)

getCurrentUser : String -> Cmd Msg
getCurrentUser jwt =
  getWithAuth currentUserUrl userDecoder jwt
    |> Http.send handleGetCurrentUserComplete

handleGetCurrentUserComplete : Result Http.Error Profile -> Msg
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
