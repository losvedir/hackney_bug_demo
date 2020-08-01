defmodule HackneyBugDemo.Acceptor do
  use GenServer
  require Logger

  def start_link(ref, transport, _opts) do
    GenServer.start_link(__MODULE__, {ref, transport})
  end

  @impl GenServer
  def init({ref, transport}) do
    Logger.info("Accepting connection...")
    {:ok, [], {:continue, {ref, transport}}}
  end

  @impl GenServer
  def handle_continue({ref, transport}, []) do
    {:ok, socket} = :ranch.handshake(ref)
    :ok = transport.setopts(socket, active: true)
    {:noreply, {transport, socket}}
  end

  @impl GenServer
  def handle_info(_msg, {transport, socket}) do
    # transport.close(socket)
    transport.send(socket, "")
    {:noreply, {transport, socket}}
  end
end
