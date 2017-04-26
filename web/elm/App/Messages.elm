module App.Messages exposing (..)

import Http exposing (Error)
import Navigation exposing (Location)
import Login.Messages as LoginMsgs
import Signup.Messages as SignupMsgs

type Msg
  = NoOp
  | OnLocationChange Location
  | LoginMsg LoginMsgs.Msg
  | SignupMsg SignupMsgs.Msg
  | RemoveLocalJWT
