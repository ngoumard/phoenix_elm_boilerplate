module Main exposing (..)

import Navigation exposing (Location)
import App.Messages exposing (Msg(OnLocationChange))
import App.Models exposing (Flags, Model, initialModel)
import App.View exposing (view)
import App.Update exposing (update)
import App.Routing as Routing exposing (Route)
import App.UrlUpdate exposing (urlUpdate)
import Users.Utils exposing (checkUserJWT)


init : Flags -> Location -> (Model, Cmd Msg)
init { localJWT } location =
  let
    currentRoute =
      Routing.parseLocation location

    currentUser =
      checkUserJWT localJWT
  in
    initialModel currentRoute currentUser
      |> urlUpdate location


main : Program Flags Model Msg
main =
  Navigation.programWithFlags OnLocationChange
    { init = init
    , view = view
    , update = update
    , subscriptions = \_ -> Sub.none
    }
