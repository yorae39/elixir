# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :todo_app,
  ecto_repos: [TodoApp.Repo]

# Configures the endpoint
config :todo_app, TodoAppWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "pFcEd2ONsYwvVj7LxgL0KpZphUeT/NiRIrzmNKxeM0xrQEH/LEo2UksD9SQ1q5Ui",
  render_errors: [view: TodoAppWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: TodoApp.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :ueberauth, Ueberauth,
  providers: [
    facebook: {Ueberauth.Strategy.Facebook, [profile_fields: "name,email,first_name,last_name",   display: "popup"]}
  ]

  config :ueberauth, Ueberauth.Strategy.Facebook.OAuth,
  client_id: "secret",
  client_secret: "secret"

"""
config :ueberauth, Ueberauth,
  providers: [
    github: {Ueberauth.Strategy.Github, [default_scope: "user,public_repo,notifications"]}
  ]

config :ueberauth, Ueberauth.Strategy.Github.OAuth,
client_id: "47fad8f3115098cff57b",
client_secret: "0c18c31f46ab5318730a61dc3ddd294436d14df7"
"""


# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
