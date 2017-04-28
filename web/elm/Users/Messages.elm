module Users.Messages exposing (..)
import Http exposing (Error)
import Users.Models exposing (Profile)

type Msg
  = NoOp
  | GetUserFailed Http.Error
  | GetUserSucceeded Profile
