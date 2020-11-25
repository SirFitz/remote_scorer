# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :scorer,
  ecto_repos: [Scorer.Repo]

# Configures the endpoint
config :scorer, ScorerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "v2nVzpeH+sxynE/SjmypGXeR03Bnzug/AnsrEhtrdxCfsHhYU3G7rnNWFMVQRnSg",
  render_errors: [view: ScorerWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Scorer.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "5khouIaD"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
