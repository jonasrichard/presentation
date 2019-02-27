defmodule Faulty.Input do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, [])
  end

  def init(_) do
    next()
    {:ok, 0}
  end

  def handle_info(:timeout, state) do
    case rem(state, 4) do
      x when x == 3 ->
        Faulty.Queue.process({:op, Enum.random([:+, :-, :*, :/])})
      _ ->
        Faulty.Queue.process({:number, :rand.uniform(100)})
    end
    next()
    {:noreply, state + 1}
  end

  defp next() do
    Process.send_after(self(), :timeout, 2000)
  end
end
