module OAuth.Config exposing (..)

import String exposing (join)
import App.Routing exposing (Route(OAuthCallbackRoute), routeToPath)
import App.Utils.Requests exposing (encodeUrl)
import App.Utils.Config exposing (rootUrl)



type alias OAuthConfig =
  { authServerUrl : String
  , redirect_uri : String
  , clientId : String
  , scopes : List String
  , state : String
  }


type alias OAuthResponse =
  { provider : String
  , token : String
  , state : String
  }

googleAuthClient : String -> OAuthConfig
googleAuthClient state =
  { authServerUrl = "https://accounts.google.com/o/oauth2/v2/auth"
  , redirect_uri = rootUrl ++ (routeToPath (OAuthCallbackRoute "google"))
  , clientId = "216293937409-cnig7jheodrsdur068b2a6bv7bb8mcok.apps.googleusercontent.com"
  , scopes = [ "profile", "email" ]
  , state = state
  }

buildAuthUrl : OAuthConfig -> String
buildAuthUrl config =
  encodeUrl
    config.authServerUrl
    [ ("client_id", config.clientId)
    , ("redirect_uri", config.redirect_uri)
    , ("response_type", "code")
    , ("access_type", "offline")
    , ("scope", join " " config.scopes)
    , ("state", config.state)
    ]
