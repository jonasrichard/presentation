defmodule SaveEts do
  use Application

  def start do
    Application.start(:save)
  end

  def start(_, _) do
    import Supervisor.Spec

    children = [worker(Task, [SaveEts, :loop, []])]
    opts = [strategy: :one_for_one, name: SaveEts.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def loop do
    receive do
      _ ->
        loop
    end
  end
end
