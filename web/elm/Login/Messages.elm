module Login.Messages exposing (..)

import Http exposing (Error)
import Users.Models exposing (UserToken)
import Form


type Msg
  = NoOp
  | GetToken (Result Http.Error UserToken)
  | FormMsg Form.Msg
