module Users.Models exposing (..)

type alias UserToken = String

type alias User =
  { jwt : UserToken
  }


userInitialModel : User
userInitialModel =
  { jwt = ""
  }
