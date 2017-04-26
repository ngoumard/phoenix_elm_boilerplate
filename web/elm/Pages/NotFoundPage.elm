module Pages.NotFoundPage exposing (..)

import Html exposing (Html, div, text)
import Components.Button exposing(buttonView)

-- Testing button component
view : Html msg
view =
    div []
        [ text "ERROR 404"
        , buttonView "primary small" "test" True
        ]
