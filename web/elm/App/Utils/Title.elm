module App.Utils.Title exposing (..)

import App.Ports exposing (appTitle)

newAppTitle : String -> String
newAppTitle pageTitle =
  let
    base =
      "PhoenixElmBoilerplate"

    newTitle =
      if (String.length pageTitle)  == 0 then
        base
      else
        pageTitle ++ " - " ++ base
  in
    newTitle
