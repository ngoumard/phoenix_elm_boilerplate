module App.Messages exposing (..)

import Http exposing (Error)
import Navigation exposing (Location)
import Login.Messages as LoginMsgs
import Signup.Messages as SignupMsgs
import Users.Messages as UsersMsgs
import Users.Models exposing (User)
import App.Translations exposing (Language)

type Msg
  = NoOp
  | OnLocationChange Location
  | LoginMsg LoginMsgs.Msg
  | SignupMsg SignupMsgs.Msg
  | UsersMsg UsersMsgs.Msg
  | RemoveLocalJWT
  | FetchCurrentUser
  | ChangeLanguage Language
