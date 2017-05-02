defmodule PhoenixElmBoilerplate.Router do
  use PhoenixElmBoilerplate.Web, :router
  alias PhoenixElmBoilerplate.Plug, as: Plug

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug Plug.Locale
  end

  pipeline :bearer_auth do
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
  end

  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated, handler: PhoenixElmBoilerplate.GuardianErrorHandler
  end

  pipeline :current_user do
    plug PhoenixElmBoilerplate.Plug.CurrentUser
  end

  scope "/api", PhoenixElmBoilerplate do
    pipe_through :api

    scope "/v1", V1, as: :v1 do
      pipe_through :api
      post "/login", SessionController, :create
      post "/signup", UserController, :create
      post "/auth/:provider/callback", AuthController, :callback
    end

    scope "/v1", V1, as: :v1 do
      pipe_through [:api, :bearer_auth, :ensure_auth, :current_user]
      get "/me", UserController, :me
      patch "/me", UserController, :update
    end
  end

  scope "/", PhoenixElmBoilerplate do
    pipe_through :browser # Use the default browser stack

    get "/*path", PageController, :index
  end
end
