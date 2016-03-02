defmodule SaveEts.Mixfile do
  use Mix.Project

  def project do
    [app: :save,
     version: "0.0.1",
     elixir: "~> 1.1",
     deps: deps]
  end

  def application do
    [applications: [],
     mod: {SaveEts, []}]
  end

  def deps do
    []
  end
end
