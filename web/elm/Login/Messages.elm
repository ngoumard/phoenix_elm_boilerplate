module Login.Messages exposing (..)

import Http exposing (Error)
import Users.Models exposing (UserToken)
import Form


type Msg
  = NoOp
  | LoginSucceeded String
  | LoginFailed Http.Error
  | LoginFormMsg Form.Msg
