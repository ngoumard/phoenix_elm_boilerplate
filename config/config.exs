# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :phoenix_elm_boilerplate,
  ecto_repos: [PhoenixElmBoilerplate.Repo]

# Configures the endpoint
config :phoenix_elm_boilerplate, PhoenixElmBoilerplate.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "YJuikCMTt3ZydnjHeUxfUxciGyTuM5ZEUSfJkTjKc3DFk3A7Hbgkgk23jDbpsSX1",
  render_errors: [view: PhoenixElmBoilerplate.ErrorView, accepts: ~w(html json)],
  pubsub: [name: PhoenixElmBoilerplate.PubSub,
           adapter: Phoenix.PubSub.PG2]

config :phoenix_elm_boilerplate, PhoenixElmBoilerplate.Gettext,
  locales: ~w(fr en),
  default_locale: "en"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :guardian, Guardian,
  allowed_algos: ["HS512"], # optional
  verify_module: Guardian.JWT,  # optional
  issuer: "PhoenixElmBoilerplate.#{Mix.env}",
  ttl: { 30, :days },
  verify_issuer: true, # optional
  secret_key: to_string(Mix.env) <> "DktpnCmmakmvXhec6bmcp6KprtPbjw7nhEr502m+k8KFt7dAZkemYkJ7ZIpBP7MM",
  serializer: PhoenixElmBoilerplate.GuardianSerializer,
  permissions: %{default: [:read, :write]}

  config :ueberauth, Ueberauth,
    providers: [
      google: {Ueberauth.Strategy.Google, [
        callback_methods: ["POST"],
        callback_path: "/api/v1/auth/google/callback",
        callback_url: System.get_env("GOOGLE_AUTH_CALLBACK_URL") || "http://localhost:4000/oauth/google" # Where my Brunch app is running
      ]}
    ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
