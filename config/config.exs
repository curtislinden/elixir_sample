# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the router
config :phoenix, ElixirExample.Router,
  url: [host: "localhost"],
  http: [port: System.get_env("PORT")],
  https: false,
  secret_key_base: "iy2xsd5iCBaOQBX3voTpuor0Vkq0uNRS42l8Jc8FXLWzS3etDtRSfpbDf2vGigy4y6ea+e3foK46nON1ENIJJg==",
  catch_errors: true,
  debug_errors: false,
  error_controller: ElixirExample.PageController

# Session configuration
config :phoenix, ElixirExample.Router,
  session: [store: :cookie,
            key: "_testp_key"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
