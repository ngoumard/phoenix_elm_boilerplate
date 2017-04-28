module App.Utils.Converters exposing (..)

import App.Translations exposing (translate, Language(..))

determineLanguage : Maybe String -> Language
determineLanguage maybeLanguage =
  let
    language =
      Maybe.withDefault "English" maybeLanguage
  in
    case language of
      "French" -> French
      _        -> English
