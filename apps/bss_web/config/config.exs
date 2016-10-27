# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :bss_web,
  ecto_repos: [BssWeb.Repo]

# Configures the endpoint
config :bss_web, BssWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "lDKTpyl/HCMjTF6Pnj7j87E4xaNcvb0blr2/A/T0LXghKWI11tko/tQ6p13iPClg",
  render_errors: [view: BssWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: BssWeb.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
