use Mix.Config

# ## SSL Support
#
# To get SSL working, you will need to set:
#
#     https: [port: 443,
#             keyfile: System.get_env("SOME_APP_SSL_KEY_PATH"),
#             certfile: System.get_env("SOME_APP_SSL_CERT_PATH")]
#
# Where those two env variables point to a file on
# disk for the key and cert.

config :phoenix, ElixirExample.Router,
  url: [host: "example.com"],
  http: [port: System.get_env("PORT")],
  secret_key_base: "iy2xsd5iCBaOQBX3voTpuor0Vkq0uNRS42l8Jc8FXLWzS3etDtRSfpbDf2vGigy4y6ea+e3foK46nON1ENIJJg=="

config :logger, :console,
  level: :info
