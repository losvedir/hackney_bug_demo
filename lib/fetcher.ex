defmodule HackneyBugDemo.Fetcher do
  use GenServer
  require Logger

  def start_link do
    GenServer.start_link(__MODULE__, [])
  end

  def connect_and_log(pid) do
    GenServer.call(pid, :connect_and_log)
  end

  def init([]) do
    :timer.apply_interval(1000, __MODULE__, :connect_and_log, [self()])
    {:ok, []}
  end

  def handle_call(:connect_and_log, _from, state) do
    stats = :hackney_pool.get_stats(:demo_pool)

    Logger.info(
      "pool_stats max=#{stats[:max]} in_use_count=#{stats[:in_use_count]} free_count=#{
        stats[:free_count]
      } queue_count=#{stats[:queue_count]}"
    )

    spawn(fn ->
      resp = :hackney.get("http://localhost:8081", [], "", [:with_body, {:pool, :demo_pool}])
      Logger.info("#{inspect(resp)}")
    end)

    {:reply, :ok, state}
  end
end
