defmodule Coordinator do
  require Logger

  def start() do
    pid = spawn fn -> loop([]) end
    Process.register(pid, Coordinator)
  end

  def loop(agents) do
    receive do
      {:new, agentpid} ->
        Process.monitor(agentpid)
        Logger.info("New agents arrived: #{inspect agentpid}")
        send(agentpid, {:registered, self()})
        loop([agentpid | agents])
      {:exec, cmd} ->
        Logger.info("Distributing command: #{inspect cmd}")
        agents
          |> Enum.each(fn(pid) -> send(pid, cmd) end)
        loop(agents)
      {:DOWN, _ref, :process, agent, _reason} ->
        List.delete(agents, agent)
          |> loop
    end
  end
end

defmodule MyAgent do
  require Logger

  def start(name) do
    spawn fn -> passive(name) end
  end

  def passive(name) do
    receive do
      {:registered, coord} ->
        Logger.info("Hey, I have a master (#{inspect coord})")
        Process.monitor(coord)
        active(name, coord)
      any ->
        Logger.warn("Outbound message: #{inspect any}")
        passive(name)
    after
      3_000 ->
        Logger.info("Try to registering... #{name}")
        case Process.whereis(Coordinator) do
          nil ->
            passive(name)
          coord ->
            send(coord, {:new, self()})
            passive(name)
        end
    end
  end

  def active(name, coord) do
    receive do
      {:exec, cmd} ->
        Logger.info("(#{inspect self()}) executes #{inspect cmd}")
        mysleep()
        active(name, coord)
      {:DOWN, _ref, :process, coord, reason} ->
        Logger.warn("Coordinator is down with #{inspect reason}")
        passive(name)
      any ->
        Logger.warn("Outbound message: #{inspect any}")
        active(name, coord)
    end
  end

  def mysleep() do
    receive do
    after 1_000 ->
      :ok
    end
  end
end
