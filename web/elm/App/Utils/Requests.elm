module App.Utils.Requests exposing (..)

import Http
import String exposing (join)
import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode exposing (Value, encode)
import Users.Models exposing (UserToken)

post : String -> Encode.Value -> Decoder value -> Http.Request value
post url json decoder =
  Http.request
    { method = "POST"
    , headers = []
    , url = url
    , body = Http.jsonBody json
    , expect = Http.expectJson decoder
    , timeout = Nothing
    , withCredentials = False
    }

getWithAuth : String -> Decode.Decoder a -> UserToken -> Http.Request a
getWithAuth url decoder token =
  Http.request
    { method = "GET"
    , headers = [ Http.header "Authorization" ("Bearer " ++ token) ]
    , url = url
    , body = Http.emptyBody
    , expect = Http.expectJson decoder
    , timeout = Nothing
    , withCredentials = False
    }
