defmodule SaveEts do
  use Application
  require Logger

  def start do
    Application.start(:save)
  end

  def start(_, _) do
    import Supervisor.Spec

    children = [
      worker(Holder, []),
      worker(Session, [])
    ]
    Logger.info("Children: #{inspect children}")
    opts = [strategy: :rest_for_one, name: SaveEts.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def loop do
    receive do
      _ ->
        loop
    end
  end
end
