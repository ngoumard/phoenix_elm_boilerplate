module Main exposing (..)

import Navigation exposing (Location)
import App.Messages exposing (Msg(OnLocationChange))
import App.Models exposing (Flags, Model, initialModel)
import App.View exposing (view)
import App.Update exposing (update)
import App.Routing as Routing exposing (Route)
import App.UrlUpdate exposing (urlUpdate)
import Users.Utils exposing (checkUserJWT)
import App.Utils.Converters exposing (determineLanguage)

init : Flags -> Location -> (Model, Cmd Msg)
init { localLanguage, localJWT } location =
  let
    currentRoute =
      Routing.parseLocation location

    currentLanguage =
      determineLanguage localLanguage

    currentUser =
      checkUserJWT localJWT
  in
    initialModel currentRoute currentUser currentLanguage
      |> urlUpdate location


main : Program Flags Model Msg
main =
  Navigation.programWithFlags OnLocationChange
    { init = init
    , view = view
    , update = update
    , subscriptions = \_ -> Sub.none
    }
