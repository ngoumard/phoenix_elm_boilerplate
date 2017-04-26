module App.Utils.Requests exposing (..)

import Http
import String exposing (join)
import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode exposing (Value, encode)

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
