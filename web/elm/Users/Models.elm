module Users.Models exposing (..)

type alias UserToken = String

type alias User =
  { jwt : UserToken
  , email : String
  }

type alias Profile =
  {
  email : String
}

userInitialModel : User
userInitialModel =
  { jwt = "", email = ""
  }

profileInitialModel : Profile
profileInitialModel =
  {
    email = ""
  }
