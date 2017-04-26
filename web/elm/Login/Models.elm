module Login.Models exposing (..)

import Form exposing (Form)
import Form.Validate as Validate exposing (..)
import Form.Field as Field exposing (Field)
import Json.Encode as Encode

type CustomError
    = ConfirmationError

type alias Credential =
    { email : String
    , password : String
    }

type alias LoginModel =
    { error : String
    , form : Form CustomError Credential
    , loading : Bool
    }

loginModelInit : LoginModel
loginModelInit =
    { error = ""
    , form = Form.initial initialFields validate
    , loading = False
    }

initialFields : List ( String, Field )
initialFields =
    [ ( "email", Field.string "" )
    , ( "password", Field.string "" )
    ]

validate : Validation CustomError Credential
validate =
    map2 Credential
        (field "email" email)
        (field "password" string)

encoder : Credential -> Encode.Value
encoder credential =
    Encode.object
        [ ( "email", Encode.string credential.email )
        , ( "password", Encode.string credential.password )
        ]
