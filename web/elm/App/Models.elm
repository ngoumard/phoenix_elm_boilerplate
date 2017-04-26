module App.Models exposing (..)

import Http
import App.Routing as Routing
import Login.Models exposing (LoginModel, loginModelInit)
import Signup.Models exposing (SignupModel, signupModelInit)
import Users.Models exposing (User)

type alias Flags =
  { localJWT : Maybe String
  }


type alias Model =
  { user : User
  , route : Routing.Route
  , login : LoginModel
  , signup : SignupModel
  }


initialModel : Routing.Route -> User -> Model
initialModel route user =
  { user = user
  , route = route
  , login = loginModelInit
  , signup = signupModelInit
  }
