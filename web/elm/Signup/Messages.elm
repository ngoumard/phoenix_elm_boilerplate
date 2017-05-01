module Signup.Messages exposing (..)

import Http
import Form
import Users.Models exposing (UserToken)


type Msg
    = SignupSucceeded String
    | SignupFailed Http.Error
    | FormMsg Form.Msg
