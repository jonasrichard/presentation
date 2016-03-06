defmodule Session do
  use GenServer
  require Logger

  def start_link() do
    result = GenServer.start_link(__MODULE__, nil, name: SessionDB)
    Logger.info("Session store started")
    result
  end

  def register(id, map) do
    GenServer.cast(SessionDB, {:register, id, map})
  end

  def get(id) do
    GenServer.call(SessionDB, {:get, id})
  end

  def init(_) do
    table = Holder.get_table()
    {:ok, table}
  end
  
  def handle_call({:get, id}, _from, table) do
    case :ets.lookup(table, id) do
      [session] ->
        {:reply, session, table}
      _ ->
        {:reply, nil, table}
    end
  end

  def handle_call(request, from, state) do
    super(request, from, state)
  end

  def handle_cast({:register, id, map}, table) do
    :ets.insert(table, {id, map})
    {:noreply, table}
  end

  def handle_cast(request, state) do
    super(request, state)
  end
end
