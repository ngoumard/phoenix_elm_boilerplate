module Signup.Messages exposing (..)

import Http
import Form
import Users.Models exposing (UserToken)


type Msg
    = GetToken (Result Http.Error UserToken)
    | FormMsg Form.Msg
