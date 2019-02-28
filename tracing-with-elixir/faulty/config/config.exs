use Mix.Config

config :logger,
  backends: [{LoggerFileBackend, :file}],
  format: "[$level] $message\n",
  handle_opt_reports: true,
  handle_sasl_reports: true

config :logger, :file,
  path: "log/faulty.log",
  level: :debug

# You can configure your application as:
#
#     config :faulty, key: :value
#
# and access this configuration in your application as:
#
#     Application.get_env(:faulty, :key)
#
# You can also configure a third-party app:
#
#     config :logger, level: :info
#

# It is also possible to import configuration files, relative to this
# directory. For example, you can emulate configuration per environment
# by uncommenting the line below and defining dev.exs, test.exs and such.
# Configuration from the imported file will override the ones defined
# here (which is why it is important to import them last).
#
#     import_config "#{Mix.env()}.exs"
