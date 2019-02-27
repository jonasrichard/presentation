defmodule Faulty.Queue do
  use GenServer
  require Logger

  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: Faulty.Queue)
  end

  def process(msg) do
    GenServer.cast(Faulty.Queue, msg)
  end

  def init(_) do
    {:ok, []}
  end

  def handle_cast({:number, number}, state) do
    {:noreply, state ++ [number]}
  end
  def handle_cast({:op, operator}, state) do
    case operator do
      :+ ->
        do_add(state)
      :- ->
        do_subtract(state)
      _ ->
        # TODO I forget this
        state
    end
    |> (fn s -> {:noreply, s} end).()
  end

  defp do_add([a, b | rest]) do
    Logger.info("#{a} + #{b} = #{a + b}")
    [a + b | rest]
  end

  defp do_subtract([a, b | rest]) do
    Logger.info("#{a} - #{b} = #{a - b}")
    [a - b | rest]
  end
end
