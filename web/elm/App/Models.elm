module App.Models exposing (..)

import Http
import App.Routing as Routing
import Login.Models exposing (LoginModel, loginModelInit)
import Signup.Models exposing (SignupModel, signupModelInit)
import Users.Models exposing (User, Profile, profileInitialModel)
import App.Translations exposing (Language(English))

type alias Flags =
  { localJWT : Maybe String
  , localLanguage : Maybe String
  }


type alias Model =
  { user : User
  , route : Routing.Route
  , login : LoginModel
  , signup : SignupModel
  , profile : Profile
  , appLanguage : Language
  , loading : Bool
  }


initialModel : Routing.Route -> User -> Language -> Model
initialModel route user language =
  { user = user
  , route = route
  , login = loginModelInit
  , signup = signupModelInit
  , profile = profileInitialModel
  , appLanguage = language
  , loading = False
  }
