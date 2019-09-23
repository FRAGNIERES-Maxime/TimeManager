# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :gotham,
  namespace: City,
  ecto_repos: [City.Repo]

# Configures the endpoint
config :gotham, CityWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "+hGDSKI3D2H8NieNtcfQ8cEq82CVaIo47Z70gW0T8O2nUrNC429KiCitCg1GIddS",
  render_errors: [view: CityWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: City.PubSub, adapter: Phoenix.PubSub.PG2]

  # Guardian config
config :city, City.Guardian,
issuer: "city",
secret_key: "fditZUVz24UkPNRpXFxd1KUztgnphRnoYh4GeWZXxJMaCwx+8XC2VMwkqoiHnllu"


# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
