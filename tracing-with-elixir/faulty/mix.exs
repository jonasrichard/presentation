defmodule Faulty.MixProject do
  use Mix.Project

  def project do
    [
      app: :faulty,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:sasl, :logger],
      mod: {Faulty.App, []}
    ]
  end

  defp deps do
    [
      {:logger_file_backend, "~> 0.0"},
      {:distillery, "~> 2.0"},
      {:dbg, "~> 1.0"},
      {:rexbug, "~> 1.0"}
    ]
  end
end
