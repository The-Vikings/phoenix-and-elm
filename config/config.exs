# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :phoenix_and_elm, ecto_repos: [PhoenixAndElm.Repo]

# Configures the endpoint
config :phoenix_and_elm, PhoenixAndElmWeb.Endpoint,
  url: [host: "localhost", port: 80],
  secret_key_base:
    "3xtybth86FwTjcafUFCdKX/sjCNq4O9vpX8PlEyAhOZ6xM43i5XdhLHAvyCpIUW7",
  render_errors: [view: PhoenixAndElmWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: PhoenixAndElm.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix_and_elm, :phoenix_swagger,
  swagger_files: %{
    "priv/static/swagger.json" => [
      router: PhoenixAndElmWeb.Router,     # phoenix routes will be converted to swagger paths
      endpoint: PhoenixAndElmWeb.Endpoint  # (optional) endpoint config used to set host, port and https schemes
    ]
  }

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

if Mix.env() == :dev do
  config :mix_test_watch,
    clear: true,
    tasks: [
      "test",
      "credo --strict"
    ]
end
