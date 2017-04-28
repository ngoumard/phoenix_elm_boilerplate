module Users.Update exposing (..)
import App.Models exposing (Model)
import Users.Messages exposing (..)
import Navigation exposing (newUrl)
import App.Routing exposing (Route(DashboardRoute), routeToPath)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    NoOp ->
      model ! []
    GetUserSucceeded profile ->
        model ! []
    GetUserFailed error ->
      model ! []
