module App.Routing exposing (..)

import Navigation exposing (Location)
import UrlParser exposing (..)



-- Available routes in our application
type Route
  = LandingRoute
  | LoginRoute
  | SignupRoute
  | DashboardRoute
  | OAuthCallbackRoute String
  | NotFoundRoute


-- Define route matchers. These parsers are provided by the url-parser library.
matchers : Parser (Route -> a) a
matchers =
  oneOf
    [ map LandingRoute          top
    , map LoginRoute       (s "login")
    , map SignupRoute       (s "signup")
    , map DashboardRoute (s "dashboard")
    , map OAuthCallbackRoute    (s "oauth" </> string)
    ]


{-
Each time the browser location changes, the Navigation library will trigger
a message containing a Navigation.Location record. From our main update
we will call parseLocation with this record.
-}
parseLocation : Location -> Route
parseLocation location =
  parsePath matchers location
    |> Maybe.withDefault NotFoundRoute


routeToPath : Route -> String
routeToPath route =
  case route of
    LandingRoute ->
      "/"
    LoginRoute ->
      "/login"
    SignupRoute ->
      "/signup"
    DashboardRoute ->
      "/dashboard"
    OAuthCallbackRoute provider ->
      "/oauth/" ++ provider
    NotFoundRoute ->
      "/"


navigateTo : Route -> Cmd msg
navigateTo route =
  Navigation.newUrl (routeToPath route)
