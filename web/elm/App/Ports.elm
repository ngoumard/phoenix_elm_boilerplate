port module App.Ports exposing (..)

port appTitle : String -> Cmd msg

port setLocalJWT : String -> Cmd msg

port removeLocalJWT : () -> Cmd msg
