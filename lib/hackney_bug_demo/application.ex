defmodule HackneyBugDemo.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Starts a worker by calling: HackneyBugDemo.Worker.start_link(arg)
      # {HackneyBugDemo.Worker, arg}
      :hackney_pool.child_spec(:demo_pool, []),
      %{id: :demo_rancher, start: {HackneyBugDemo.Rancher, :start_link, []}, type: :supervisor},
      %{id: :fetcher1, start: {HackneyBugDemo.Fetcher, :start_link, []}},
      %{id: :fetcher2, start: {HackneyBugDemo.Fetcher, :start_link, []}},
      %{id: :fetcher3, start: {HackneyBugDemo.Fetcher, :start_link, []}}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: HackneyBugDemo.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
