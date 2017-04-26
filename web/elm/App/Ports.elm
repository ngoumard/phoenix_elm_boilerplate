port module App.Ports exposing (..)

port setLocalJWT : String -> Cmd msg

port removeLocalJWT : () -> Cmd msg
