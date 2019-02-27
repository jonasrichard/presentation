defmodule Faulty.App do
  use Application

  def start(_type, _args) do
    children = [
      Faulty.Queue,
      Faulty.Input
    ]
    opts = [strategy: :one_for_one, name: Faulty.Sup]
    Supervisor.start_link(children, opts)
  end
end
