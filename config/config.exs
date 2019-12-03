import Config

config :brazex,
  http_client: Brazex.HttpClient

import_config "#{Mix.env()}.exs"
